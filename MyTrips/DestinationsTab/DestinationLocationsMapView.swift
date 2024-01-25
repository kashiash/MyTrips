//
//  DestinationLocationsMapView.swift
//  MyTrips
//
//  Created by Jacek Kosinski U on 18/01/2024.
//

import SwiftUI
import MapKit
import SwiftData

struct DestinationLocationsMapView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?


    @State  var destination: Destination

    @State private var searchText = ""
    @FocusState private var searchFieldFocus: Bool
    @Query(filter: #Predicate<MTPlacemark>{$0.destination == nil}) private var  searchPlacemarks: [MTPlacemark]

    private var listPlacemarks: [MTPlacemark] {
        searchPlacemarks + destination.placemarks
    }
    @State private var selectedPlacemark: MTPlacemark?
    @State private var selectedCategory: String = ""
    @State private var isManualMarker = false

    var body: some View {
        @Bindable var destination = destination

        VStack{
            LabeledContent {
                TextField("Enter destination name", text: $destination.name)
                    .textFieldStyle(.roundedBorder)
                 //   .foregroundStyle(.primary)

            } label: {
                Text("Name")
            }

            HStack{
                Text("Adjust the map to set the region for current destination.")
                    .foregroundStyle(.secondary)
                    .font(.caption)
                Spacer()
                Button("Set region")
                {
                    if let visibleRegion {
                        destination.latitude = visibleRegion.center.latitude
                        destination.longitude = visibleRegion.center.longitude
                        destination.latitudeDelta = visibleRegion.span.latitudeDelta
                        destination.longitudeDelta = visibleRegion.span.longitudeDelta
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .background(.ultraThinMaterial)
        .padding(.horizontal)
        MapReader{ proxy in
        Map(position: $cameraPosition, selection: $selectedPlacemark) {
            ForEach(listPlacemarks) {placemark in
                if isManualMarker {
                    if placemark.destination != nil {
                        Marker(coordinate: placemark.coordinate) {
                            Label(placemark.name,systemImage: "star")
                        }
                        .tint(.yellow)
                    } else {
                        Marker(placemark.name,coordinate: placemark.coordinate)
                    }
                } else  {
                    Group {
                        if placemark.destination != nil {
                            Marker(coordinate: placemark.coordinate) {
                                Label(placemark.name,systemImage: "star")
                            }
                            .tint(.yellow)
                        } else {
                            Marker(placemark.name,coordinate: placemark.coordinate)
                        }
                    }
                    .tag(placemark)
                }
            }

        }
        .ignoresSafeArea()
        .overlay(alignment: .leading) {
            VStack {
                Button("",systemImage:"fuelpump.circle"){
                    selectedCategory = "gasStation"
                }


                Button("",systemImage:"parkingsign.circle"){
                    selectedCategory = "parking"
                }


            }
            .font(.largeTitle)

            .foregroundColor(.red)
            .background(.white.opacity(0.2))

        }
        .mapStyle(.hybrid)
        .mapControls{
            MapUserLocationButton()
            MapScaleView()
            MapPitchToggle()
            //MapZoomStepper()
        }
        .onTapGesture { position in
            print("tap position: \(position)")
            if isManualMarker {
                if let coordinate = proxy.convert(position, from: .local) {
                    let mtPlacemark = MTPlacemark(name: "", address: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                    modelContext.insert(mtPlacemark)
                    selectedPlacemark = mtPlacemark
                }
            }

        }

        .gesture(LongPressGesture(
            minimumDuration: 0.25)
            .sequenced(before: DragGesture(
                minimumDistance: 0,
                coordinateSpace: .local))
                .onEnded { value in
                    switch value {
                    case .second(true, let drag):
                      let  longPressLocation = drag?.location ?? .zero
                        print("x: \(longPressLocation.x) - y: \(longPressLocation.y)")

                        if let coordinate = proxy.convert(longPressLocation, from: .local) {
                            let mtPlacemark = MTPlacemark(name: "", address: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                            modelContext.insert(mtPlacemark)
                            selectedPlacemark = mtPlacemark
                        }

                    default:
                        break
                    }
                })

    }
        .sheet(item: $selectedPlacemark, onDismiss: {
            if isManualMarker {
                MapManager.removeSearchResults(modelContext)
            }
        })
        { selectedPlacemark in
            LocationDetailView( destination: destination, selectedPlacemark: selectedPlacemark)
                .presentationDetents([.medium])
        }
        .safeAreaInset(edge: .bottom) {
            VStack {
                Toggle(isOn: $isManualMarker) {
                    Label("Tap marker placement is: \(isManualMarker ? "ON" : "OFF")", systemImage: isManualMarker ? "mappin.circle" :  "mappin.slash.circle")
                }
                .fontWeight(.bold)
                .toggleStyle(.button)
                .background(.ultraThinMaterial)
                .onChange(of: isManualMarker) {
                    MapManager.removeSearchResults(modelContext)
                }
                if !isManualMarker {
                HStack {
                    TextField("Search...", text: $searchText)

                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .focused($searchFieldFocus)
                        .overlay(alignment: .trailing) {
                            if searchFieldFocus {
                                Button {
                                    searchText = ""
                                    searchFieldFocus = false
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                }
                                .offset(x: -5)
                            }
                        }

                        .onSubmit {
                            Task{
                                await MapManager.searchPlaces(modelContext,searchText: searchText, visibleRegion: visibleRegion)
                                searchText = ""
                                cameraPosition = .automatic
                            }
                        }
                    if !searchPlacemarks.isEmpty {
                        Button {
                            MapManager.removeSearchResults(modelContext)
                        } label: {
                            Image(systemName: "mappin.slash.circle.fill")
                                .imageScale(.large)
                        }
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.red)
                        .clipShape(.circle)
                    }
                }

                .padding(.horizontal)
                }
            }
        }
       .navigationTitle("Destination")
       .navigationBarTitleDisplayMode(.inline)

        .onMapCameraChange(frequency: .onEnd) { context in
            visibleRegion = context.region
        }
        .onChange(of: selectedCategory, { _, _ in
            Task{
                await MapManager.searchPlaces(modelContext,searchText: selectedCategory, visibleRegion: visibleRegion)
                searchText = ""
                cameraPosition = .automatic
            }
        })
        .onAppear{

            if let region = destination.region {
                cameraPosition = .region(region)
            }
        }
    }
}

#Preview {
    let container = Destination.preview
    let fetchDescriptior = FetchDescriptor<Destination>()
    let destination = try! container.mainContext.fetch(fetchDescriptior)[0]
    return NavigationStack{
        DestinationLocationsMapView(destination: destination)
    }
    .modelContainer(Destination.preview)
}

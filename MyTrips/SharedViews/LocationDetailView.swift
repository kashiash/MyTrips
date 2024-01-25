//
//  LocationDetailView.swift
//  MyTrips
//
//  Created by Jacek Kosinski U on 21/01/2024.
//

import SwiftUI
import SwiftData
import MapKit

struct LocationDetailView: View {

    var destination: Destination?
    var selectedPlacemark: MTPlacemark?
    @Environment(\.dismiss) private var dismiss
    @State private var name = ""
    @State private var address = ""
    @State private var description = ""

    @State private var lookaroundScene: MKLookAroundScene?

    var isChanged: Bool {
        guard let selectedPlacemark else { return false }
        return (name != selectedPlacemark.name || address != selectedPlacemark.address)
    }
    var body: some View {
        VStack{
            HStack{
                VStack {
                    TextField("Name",text: $name)
                        .font(.title)
                    TextField("Address",text: $address, axis: .vertical)
                    TextField("Description",text: $description, axis: .horizontal)


                    if isChanged {
                        Button("Update") {
                            selectedPlacemark?.name = name
                                .trimmingCharacters(in: .whitespacesAndNewlines)
                            selectedPlacemark?.address = address
                                .trimmingCharacters(in: .whitespacesAndNewlines)
                            selectedPlacemark?.placemarkDescription = description
                                .trimmingCharacters(in: .whitespacesAndNewlines)
                            //   dismiss()
                        }
                        .frame(maxWidth: .infinity,alignment: .trailing)
                        .buttonStyle(.borderedProminent)
                    }
                }
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                    Spacer()
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .imageScale(.large)
                            .foregroundStyle(.gray)
                    }

            }
            if let lookaroundScene {
                LookAroundPreview(initialScene: lookaroundScene)
                    .frame(height: 200)
                    .padding()
            } else {
                ContentUnavailableView {

                    Image(systemName: "mappin.slash.circle")
                        .font(.largeTitle)
                    Text("Content unavaiable")
                        .foregroundStyle(.red)
                }
            }
            HStack {
                Spacer()
                if let destination {
                    let inList = (selectedPlacemark != nil && selectedPlacemark?.destination != nil)
                    Button{
                        if let selectedPlacemark {
                            if selectedPlacemark.destination == nil {
                                destination.placemarks.append(selectedPlacemark)
                            } else {
                                selectedPlacemark.destination = nil
                            }
                            dismiss()
                        }
                    } label: {
                        Label(inList ? "Remove" : "Add", systemImage: inList ?  "minus.circle" : "plus.circle")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(inList ? .red : .green)
                    .disabled(name.isEmpty || isChanged)
                }
            }
            Spacer()

        }
        .padding()
        .task(id: selectedPlacemark) {
            await fetchLookaroundPreview()
        }
        .onAppear{
            if let selectedPlacemark, destination != nil {
                name = selectedPlacemark.name
                address = selectedPlacemark.address
                description = selectedPlacemark.placemarkDescription

            }
        }
    }
    func fetchLookaroundPreview() async {
        if let selectedPlacemark {
            lookaroundScene = nil
            let lookaroundRequest = MKLookAroundSceneRequest(coordinate: selectedPlacemark.coordinate)
            lookaroundScene = try? await lookaroundRequest.scene
        }
    }
}

#Preview {
    let container = Destination.preview
    let fetchDescriptior = FetchDescriptor<Destination>()
    let destination = try! container.mainContext.fetch(fetchDescriptior)[0]
    let selectedPlacemark = destination.placemarks[0]

    return    LocationDetailView(destination: destination,selectedPlacemark: selectedPlacemark)

}

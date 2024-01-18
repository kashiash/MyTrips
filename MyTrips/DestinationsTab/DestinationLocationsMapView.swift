//
//  DestinationLocationsMapView.swift
//  MyTrips
//
//  Created by Jacek Kosinski U on 18/01/2024.
//

import SwiftUI
import MapKit

struct DestinationLocationsMapView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var visibleRegion: MKCoordinateRegion?
    var body: some View {
        Map(position: $cameraPosition) {

            Marker( "Royal Castle", coordinate: .royalCastle)

            Marker( coordinate: .wilanowPalace)
            {
                Label("Wilanów Palace",systemImage: "star.fill")
            }
            .tint(.yellow)

            Marker( "Old Town Market Place", coordinate: .oldTownMarketPlace)
            Marker( "Łazienki Park", coordinate: .lazienkiPark)

            Marker( "Palace of Culture and Science",systemImage: "star.fill",
                    coordinate: .palaceOfCulture)

            Marker( "Warsaw Uprising Museum",systemImage: "star.fill" ,
                    coordinate: .uprisingMuseum)
            .tint(.blue)

            Marker( "Copernicus Science Centre",systemImage: "atom", coordinate: .copernicusScienceCentre)

            Marker( "POLIN Museum",monogram: Text("POLIN"), coordinate: .polinMuseum)

            Marker( "National Stadium", coordinate: .nationalStadium)
            Marker( "Vistula River", coordinate: .vistulaRiver)
            Marker( "Warsaw Zoo", image:"orlen",coordinate: .warsawZoo)

            Annotation("Chopin Monument",coordinate: .chopinMonument) {
                Image(systemName: "star")
                    .imageScale(.large)
                    .foregroundStyle(.red)
                    .padding(10)
                    .background(.white)
                    .clipShape(.circle)
            }

            Annotation("Stara chata",coordinate: .nowySwiatStreet) {
                Image(.staraChata)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40,height: 40)
                    .clipShape(.circle)
            }

            Annotation("Fountains",coordinate: .fountainPark) {
                Image(systemName: "mappin")
                    .imageScale(.large)
                    .foregroundStyle(.red)
                    .padding(5)
                    .overlay {
                        Circle()
                            .strokeBorder(.red,lineWidth: 2)
                    }
            }

            MapCircle(
                center: .palaceOfCulture,
                radius: 5000
            )
            .foregroundStyle(.red.opacity(0.3))

        }
        .onMapCameraChange(frequency: .onEnd) { context in
            visibleRegion = context.region
        }
        .onAppear{
            // 52.231972, 21.007179

            let  pkin = CLLocationCoordinate2D(latitude: 52.231972, longitude: 21.007179)


            let wawaSpan = MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
            let wawaRegion = MKCoordinateRegion(center: pkin, span: wawaSpan)
            cameraPosition = .region(wawaRegion)
        }
    }
}

#Preview {
    DestinationLocationsMapView()
}

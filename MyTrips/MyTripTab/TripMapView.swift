//
//  TripMapView.swift
//  MyTrips
//
//  Created by Jacek Kosinski U on 18/01/2024.
//

import SwiftUI
import MapKit
import SwiftData

struct TripMapView: View {
    @Environment(LocationManager.self) var locationManager
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)


    @Query private var listPlacemarks: [MTPlacemark]
    let manager = CLLocationManager()
    var body: some View {
        Map(position: $cameraPosition)
        {
            UserAnnotation()
            ForEach(listPlacemarks) { placemark in
                Marker(coordinate: placemark.coordinate) {
                    Label(placemark.name,systemImage: "star")
                }
                .tint(.yellow)
            }
        }
        .mapControls({
            MapUserLocationButton()
        })
        .onAppear(perform: {
            manager.requestAlwaysAuthorization()
        })

    }
}

#Preview {
    TripMapView()
        .environment(LocationManager())
}

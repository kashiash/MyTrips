//
//  MyTripsApp.swift
//  MyTrips
//
//  Created by Jacek Kosinski U on 18/01/2024.
//

import SwiftUI
import SwiftData

@main
struct MyTripsApp: App {
    @State private var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            if locationManager.isAuthorized {
                StartTab()
            } else {
                Text("need to help user")
            }

        }

        .modelContainer(for: Destination.self)
    }
}

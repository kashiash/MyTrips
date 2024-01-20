//
//  StartTab.swift
//  MyTrips
//
//  Created by Jacek Kosinski U on 18/01/2024.
//

import SwiftUI

struct StartTab: View {
    var body: some View {
        TabView {
            Group{
                TripMapView()
                    .tabItem {
                        Label("TripMap", systemImage: "map")
                    }
                DestinationsListView()
                    .tabItem {
                        Label("Destinations", systemImage: "globe.desk")
                    }
            }
            .toolbarBackground(.appBlue.opacity(0.8), for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
        }
    }
}

#Preview {
    StartTab().modelContainer(Destination.preview)
}

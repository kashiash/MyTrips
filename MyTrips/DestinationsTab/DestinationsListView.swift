//
//  DestinationsListView.swift
//  MyTrips
//
//  Created by Jacek Kosinski U on 20/01/2024.
//

import Foundation
import SwiftUI
import SwiftData

struct DestinationsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Destination.name) private var destinations: [Destination]
    @State private var showNewDestionationAlert = false
    @State private var destinationName = ""
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            Group{
                if !destinations.isEmpty {
                    List(destinations) { destination in
                        NavigationLink(value: destination) {
                            HStack{
                                Image(systemName: "globe")
                                    .imageScale(.large)
                                //.foregroundStyle(.accent)
                                VStack(alignment: .leading) {
                                    Text(destination.name)
                                    Text("^[\(destination.placemarks.count) location](inflect: true)")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                modelContext.delete(destination)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }

                    }
                    .navigationDestination(for: Destination.self) { destination in
                        DestinationLocationsMapView(destination:destination)
                    }
                } else {
                    ContentUnavailableView("No Destinations", systemImage: "globe.desk", description: Text("You have not se up any destinations yet. Tap on the \(Image(systemName: "plus.circle.fill")) button in the toolbar to begin"))
                }
            }
            .navigationTitle("My Destinations")
            .toolbar {
                Button{
                    showNewDestionationAlert.toggle()
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .alert("Enter Destination Name",isPresented: $showNewDestionationAlert) {
                    TextField("Enter destination name", text: $destinationName)
                    Button("OK") {
                        if !destinationName.isEmpty {
                            let destination = Destination(name: destinationName)
                            modelContext.insert(destination)
                            destinationName = ""
                            path.append(destination)
                        }
                    }
                    Button("Cancel",role: .cancel) {
                        destinationName = ""
                    }
                } message: {
                    Text("Create a new destination")
                }
            }
        }
    }
}

#Preview{
    DestinationsListView()
        .modelContainer(Destination.preview)
}

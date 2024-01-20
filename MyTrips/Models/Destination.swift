//
//  Destination.swift
//  MyTrips
//
//  Created by Jacek Kosinski U on 19/01/2024.
//

import Foundation
import SwiftData
import MapKit

@Model
class Destination {
    var name: String
    var latitude: Double?
    var latitudeDelta: Double?
    var longitude: Double?
    var longitudeDelta: Double?
    @Relationship(deleteRule: .cascade)
    var placemarks: [MTPlacemark] = []

    init(name: String, latitude: Double? = nil, latitudeDelta: Double? = nil, longitude: Double? = nil, longitudeDelta: Double? = nil) {
        self.name = name
        self.latitude = latitude
        self.latitudeDelta = latitudeDelta
        self.longitude = longitude
        self.longitudeDelta = longitudeDelta
    }

    var region: MKCoordinateRegion? {
        if let latitude, let longitude, let latitudeDelta, let longitudeDelta {
            return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude , longitude: longitude),
                                      span: MKCoordinateSpan(latitudeDelta: latitudeDelta, longitudeDelta: longitudeDelta))
        } else {
            return nil
        }

    }
}

extension Destination {
    @MainActor
    static var preview: ModelContainer {
        let container = try! ModelContainer(
            for: Destination.self,
            configurations: ModelConfiguration(
                isStoredInMemoryOnly: true
            )
        )


        let wawa = Destination(name: "Warszawa",
                               latitude: 52.231972,
                               latitudeDelta: 0.15,
                               longitude:21.007179 ,
                               longitudeDelta: 0.15
        )
        container.mainContext.insert(wawa)

        var placemarks: [MTPlacemark] {
            [
                MTPlacemark(name: "Royal Castle", address: "Warsaw", latitude: 52.248044, longitude: 21.013935),
             MTPlacemark(name: "Wilanow Palace", address: "Warsaw", latitude: 52.165955, longitude: 21.090379),
            MTPlacemark(name: "Old Town Market Place", address: "Warsaw", latitude: 52.249292, longitude: 21.012072),
            MTPlacemark(name: "Lazienki Park", address: "Warsaw", latitude: 52.214994, longitude: 21.035262),

             MTPlacemark(name: "National Museum", address: "Aleje Jerozolimskie 3, Warsaw", latitude: 52.231959, longitude: 21.007699),

             MTPlacemark(name: "Copernicus Science Center", address: "Wybrzeże Kościuszkowskie 20, Warsaw", latitude: 52.2396, longitude: 21.0445),

             MTPlacemark(name: "Warsaw Uprising Museum", address: "Grzybowska 79, Warsaw", latitude: 52.2326, longitude: 20.9827),

             MTPlacemark(name: "Palace of Culture and Science", address: "Plac Defilad 1, Warsaw", latitude: 52.231923, longitude: 21.005184),

             MTPlacemark(name: "Powązki Cemetery", address: "Powązkowska 8, Warsaw", latitude: 52.260816, longitude: 20.984171),

             MTPlacemark(name: "Wilanów Park", address: "Stanisława Kostki Potockiego 10/16, Warsaw", latitude: 52.165625, longitude: 21.103261),

             MTPlacemark(name: "Chopin Museum", address: "Ostrogski Palace, Okólnik 1, Warsaw", latitude: 52.239666, longitude: 21.013574),

             MTPlacemark(name: "Praga District", address: "Targowa 74, Warsaw", latitude: 52.252812, longitude: 21.043453),

             MTPlacemark(name: "Zoo Warsaw", address: "Ratuszowa 1/3, Warsaw", latitude: 52.237148, longitude: 20.987155),

             MTPlacemark(name: "Polish Vodka Museum", address: "Wierzbowa 9/11, Warsaw", latitude: 52.247754, longitude: 21.005517),

             MTPlacemark(name: "Holy Cross Church", address: "Krakowskie Przedmieście 3, Warsaw", latitude: 52.238349, longitude: 21.017532),

             MTPlacemark(name: "Saxon Garden", address: "Marszałkowska 10/16, Warsaw", latitude: 52.238879, longitude: 21.015677),

             MTPlacemark(name: "Multimedia Fountain Park", address: "Saski Park, Warsaw", latitude: 52.242515, longitude: 21.013608),

             MTPlacemark(name: "Praski Park", address: "Park Praski, Warsaw", latitude: 52.250032, longitude: 21.056926),

             MTPlacemark(name: "Museum of the History of Polish Jews", address: "Anielewicza 6, Warsaw", latitude: 52.250778, longitude: 20.999187)


             ]
        }

        placemarks.forEach { placemark in
            wawa.placemarks.append(placemark)
        }

        return container
    }
}

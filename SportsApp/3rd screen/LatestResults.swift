//
//  UpcomingEvent.swift
//  SportsApp
//
//  Created by Mina Kamal on 12.06.22.
//

import Foundation

struct Events: Codable {
    var events: [Event]
}

struct Event: Codable {
    let strHomeTeam: String?
    let strAwayTeam: String?
    let intHomeScore: String?
    let intAwayScore: String?
    let dateEvent: String?
    let strTime: String?
    let strThumb: String?
}

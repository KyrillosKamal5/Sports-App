//
//  Leagues.swift
//  SportsApp
//
//  Created by Kyrillos Kamal on 09.06.22.
//

import Foundation

struct Countries: Codable {
    var countries: [LeagueModel]
}

struct LeagueModel: Codable{
    let idLeague: String
    let strLeague: String
    let strBadge: String
    let strYoutube: String?
}

//
//  Team.swift
//  SportsApp
//
//  Created by Kyrillos Kamal on 10.06.22.
//

import Foundation


struct Teams: Codable {
    var teams: [Team]
}

struct Team: Codable{
    let strTeam: String?
    let intFormedYear: String?
    let idLeague: String?
    let strStadiumThumb: String?
    let strFacebook: String?
    let strTwitter: String?
    let strInstagram: String?
    let strDescriptionEN: String?
    let strCountry: String?
    let strTeamBadge: String?
}

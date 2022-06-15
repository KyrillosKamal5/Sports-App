//
//  Sports.swift
//  SportsApp
//
//  Created by Mina Kamal on 06.06.22.
//

import Foundation

struct Sports: Decodable {
    var sports: [Sport]
}

struct Sport: Decodable{
//    var idSport: String
    var strSport: String
//    var strFormat: String
    var strSportThumb: String
//    var strSportIconGreen: String
//    var strSportDescription: String
}

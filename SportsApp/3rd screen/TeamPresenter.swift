//
//  leagueDetailsPresenter.swift
//  SportsApp
//
//  Created by Mina Kamal on 11.06.22.
//

import Foundation

protocol TeamProtocol {
    func getTeam(teamName: String, completionHandler: @escaping ([Team]) -> Void)
    
}

class TeamPresenter {
    
    var dataTeam: TeamsDataProtocol?
    weak var leagueVC: LeagueDetailsViewController?
    
    init(dataTeam: TeamsDataProtocol, leagueVC: LeagueDetailsViewController) {
        self.dataTeam = dataTeam
        self.leagueVC = leagueVC
        }
    }

extension TeamPresenter: TeamProtocol{
    func getTeam(teamName: String, completionHandler: @escaping ([Team]) -> Void) {
       var uri = teamName.replacingOccurrences(of: " ", with: "%20")
        dataTeam?.getTeams(teamName: uri, completionHandler: { teams in
            completionHandler(teams)
        })
    }
}


//
//  LeaguesPresenter.swift
//  SportsApp
//
//  Created by Mina Kamal on 09.06.22.
//

import Foundation

protocol LeaguesPresenterProtocol{
    func getDataLeagues(sportName: String, completionHandler: @escaping  ([LeagueModel]) -> Void)
}

class LeaguesPresenter {
    var dataLeagues: LeaguesDataProtocol?
    weak var leagueVC: LeaguesTableViewController?
    
    init(dataLeagues: LeaguesDataProtocol, leagueVC: LeaguesTableViewController) {
        self.dataLeagues = dataLeagues
        self.leagueVC = leagueVC
    }
    
}

extension LeaguesPresenter: LeaguesPresenterProtocol{
    func getDataLeagues(sportName: String, completionHandler: @escaping ([LeagueModel]) -> Void) {
        dataLeagues?.getLeagues(sportName: sportName, completionHandler: { countries in
            completionHandler(countries)
        })
    }
}

//func getDataLeagues(completionHandler: @escaping ([League]) -> Void) {
//    dataLeagues?.getLeagues(completionHandler: { countries in
//        completionHandler(countries)
//    })
//}

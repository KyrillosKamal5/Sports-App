//
//  DataSource.swift
//  SportsApp
//
//  Created by Mina Kamal on 07.06.22.
//

import Foundation
import Alamofire



protocol SportsDataProtocol{
    func getSports(completionHandler: @escaping ([Sport]) -> Void)
}

protocol LeaguesDataProtocol{
    func getLeagues (sportName: String, completionHandler: @escaping ([LeagueModel]) -> Void)
}

protocol TeamsDataProtocol{
    func getTeams(teamName: String, completionHandler: @escaping ([Team]) -> Void)
}

protocol LatestResultsProtocol {
    func getLatestResults(leagueID: String, completionHandler: @escaping ([Event]?, Error?) -> Void )
}


class DataSource {
    
    static let sharedInstance = DataSource()
    
    private init(){
        
    }
}

extension DataSource: SportsDataProtocol{
    func getSports(completionHandler: @escaping ([Sport]) -> Void){
        AF.request("https://www.thesportsdb.com/api/v1/json/2/all_sports.php").responseDecodable(of: Sports.self) { response in
            completionHandler(response.value?.sports ?? [])
        }
    }
}

extension DataSource: LeaguesDataProtocol{
    func getLeagues(sportName: String, completionHandler: @escaping ([LeagueModel]) -> Void) {
        let parameters: Parameters = [
            "s": sportName
        ]
        AF.request("https://www.thesportsdb.com/api/v1/json/2/search_all_leagues.php", parameters: parameters)
            .responseDecodable(of: Countries.self) { response in
                completionHandler(response.value!.countries)
            }
    }
}

extension DataSource: TeamsDataProtocol{
    func getTeams(teamName: String, completionHandler: @escaping ([Team]) -> Void) {
//        let parameters: Parameters = ["l": teamName]
        AF.request("https://www.thesportsdb.com/api/v1/json/2/search_all_teams.php?l=\(teamName)").responseDecodable(of: Teams.self) {
            response in
            
            if response.value != nil {
                completionHandler(response.value!.teams)
            }
        }
    }
}

extension DataSource : LatestResultsProtocol{
    func getLatestResults( leagueID: String, completionHandler: @escaping ([Event]?, Error?) -> Void) {
        let parameters: Parameters = ["id": leagueID]
        AF.request("https://www.thesportsdb.com/api/v1/json/2/eventsseason.php", parameters: parameters).responseDecodable(of: Events.self) { response in
            if response.value != nil {
                completionHandler(response.value!.events, nil)
            }else{
                completionHandler(nil, response.error )
            }
        }
    }

}





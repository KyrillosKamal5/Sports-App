//
//  LatestEvents.swift
//  SportsApp
//
//  Created by Mina Kamal on 12.06.22.
//

import Foundation

protocol ResultsLatestProtocol {
    func getLatest(leagueID: String, completionHandler: @escaping ([Event], [Event]) -> Void)
}


class LatestResultsPresenter {
    var latestResultsData: LatestResultsProtocol?
    weak var latestResultVC: LeagueDetailsViewController?
    
    var upcomingEvents = [Event]()
    var latestResults = [Event]()
    
    init(latestResultsData: LatestResultsProtocol, latestResultVC: LeagueDetailsViewController ) {
        self.latestResultVC = latestResultVC
        self.latestResultsData = latestResultsData
    }
}


extension LatestResultsPresenter: ResultsLatestProtocol {
    func getLatest(leagueID: String, completionHandler: @escaping ([Event], [Event]) -> Void){
        latestResultsData?.getLatestResults(leagueID: leagueID, completionHandler: { events in
            events.forEach { event in
                event.dateEvent
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                
                var x = formatter.date(from: event.dateEvent ?? "")
                var y = formatter.date(from: "2021-12-01")
                print("$\(event.dateEvent)")
                
                if x! > y! {
                    self.upcomingEvents.append(event)
                }else if x! < y! {
                    self.latestResults.append(event)
                }else{
                    print("No Data found")
                }
            }
            completionHandler(self.upcomingEvents, self.latestResults)
        })
    }
    
}

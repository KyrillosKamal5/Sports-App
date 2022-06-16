//
//  LatestEvents.swift
//  SportsApp
//
//  Created by Mina Kamal on 12.06.22.
//

import Foundation
import CoreData


protocol ResultsLatestProtocol {
    func getLatest(leagueID: String, completionHandler: @escaping ([Event], [Event]) -> Void)
    func setAppDelegateAndViewContext(appDelagate: AppDelegate, viewContext: NSManagedObjectContext)
    func saveLeague(league: LeagueModel)
    func deleteLeague(league: LeagueModel)
    func isFavoriteLague (leagueID: String) -> Bool
}



class LeagueDetailsPresenter {
    var latestResultsData: LatestResultsProtocol?
    weak var latestResultVC: LeagueDetailsViewController?
    
    var upcomingEvents = [Event]()
    var latestResults = [Event]()
    
    var localDataSource = LocalDataSource.sharedInstance
  
    
    init(latestResultsData: LatestResultsProtocol, latestResultVC: LeagueDetailsViewController ) {
        self.latestResultVC = latestResultVC
        self.latestResultsData = latestResultsData
    }
    
}


extension LeagueDetailsPresenter: ResultsLatestProtocol {
    func setAppDelegateAndViewContext(appDelagate: AppDelegate, viewContext: NSManagedObjectContext) {
        localDataSource.setAppDelegateAndContext(appDelagate: appDelagate, viewContext: viewContext)
    }
    
    func deleteLeague(league: LeagueModel){
        localDataSource.deleteLeague(league: league)
    }
    
    func saveLeague(league: LeagueModel) {
        localDataSource.saveLeague(league: league)
    }
    
    func getLatest(leagueID: String, completionHandler: @escaping ([Event], [Event]) -> Void){
        latestResultsData?.getLatestResults(leagueID: leagueID, completionHandler: { events, error in
            
            
            if error == nil {
                events?.forEach { event in
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
            }
        })
    }
    
    func isFavoriteLague (leagueID: String) -> Bool{
        self.localDataSource.isFavoriteLague(leagueID: leagueID)
    }
}

//
//  FavoritePresenter.swift
//  SportsApp
//
//  Created by Kyrillos Kamal on 16.06.22.
//

import Foundation
import CoreData

protocol FavoritesPresenterProtocol{
    func getFavLeagues()-> [LeagueModel]
    func setAppDelegateAndViewContext(appDelagate: AppDelegate, viewContext: NSManagedObjectContext)
}

class FavoritePresenter{
    
    var localDataSource = LocalDataSource.sharedInstance
    
    init() {
    }
    
    func setAppDelegateAndViewContext(appDelagate: AppDelegate, viewContext: NSManagedObjectContext){
        
        localDataSource.setAppDelegateAndContext(appDelagate: appDelagate, viewContext: viewContext)
    }
}

extension FavoritePresenter: FavoritesPresenterProtocol{
    func getFavLeagues()-> [LeagueModel]{
        return localDataSource.getFavLeague()
    }
}


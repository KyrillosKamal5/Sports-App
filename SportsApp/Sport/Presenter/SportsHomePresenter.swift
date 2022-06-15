//
//  SportsHomePresenter.swift
//  SportsApp
//
//  Created by Mina Kamal on 07.06.22.
//

import Foundation

protocol SportsPresenterProtocol {
    func getSports(completionHandler: @escaping ([Sport]) ->Void)
    
}


class SportsHomePresenter {
    
    var dataSource: SportsDataProtocol
    var sportsVC: SportsCollectionViewController
    
    
    init(dataSource: SportsDataProtocol, sportsVC: SportsCollectionViewController) {
        self.dataSource = dataSource
        self.sportsVC = sportsVC
    }
}

extension SportsHomePresenter: SportsPresenterProtocol{
    func getSports(completionHandler: @escaping ([Sport]) ->Void){
        dataSource.getSports { sports in
            completionHandler(sports)
        }
    }
}

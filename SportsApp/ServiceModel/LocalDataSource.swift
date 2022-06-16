//
//  LocalDataSource.swift
//  SportsApp
//
//  Created by Mina Kamal on 15.06.22.
//

import Foundation
import CoreData

class LocalDataSource{

    var appDelagate: AppDelegate?
    var viewContext: NSManagedObjectContext?
    var currentLeague: NSManagedObject?

    
    static let sharedInstance = LocalDataSource()
    
  private  init() {
      
    }
    
    func setAppDelegateAndContext (appDelagate: AppDelegate, viewContext: NSManagedObjectContext) {
        self.appDelagate = appDelagate
        self.viewContext = viewContext
    }
    
    func deleteLeague (league: LeagueModel) {
        guard let viewContextview = viewContext,
              let currentLeague = currentLeague
        else {return}
        viewContext?.delete(currentLeague)
        appDelagate?.saveContext()
    }
    
    
    func saveLeague(league: LeagueModel){
        let isExistedBefore = isFavoriteLague(leagueID: league.idLeague)
                if !isExistedBefore {
                    guard let viewContext = viewContext ,
                    let entity = NSEntityDescription.entity(forEntityName: "LeagueT", in: viewContext) else {return}
                    let leagueEntity = NSManagedObject(entity: entity, insertInto: viewContext)
                    leagueEntity.setValue(league.strLeague, forKey: "title")
                    leagueEntity.setValue(league.strBadge, forKey: "image")
                    leagueEntity.setValue(league.strYoutube, forKey: "youtube")
                    leagueEntity.setValue(league.idLeague, forKey: "id")
                    appDelagate?.saveContext()
                }
    }
    
    func getFavLeague() ->[LeagueModel]{
        guard let viewContext = viewContext else {return [LeagueModel]()}
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueT")
        do{
            let leaguesEntities = try viewContext.fetch(fetchRequest)
            
            var leagueObjects = [LeagueModel]()
            
            leaguesEntities.forEach { leagueEntity in
                
                let currentLeague = LeagueModel(idLeague: leagueEntity.value(forKey: "id") as! String, strLeague: leagueEntity.value(forKey: "title") as! String,  strBadge: leagueEntity.value(forKey: "image") as! String,  strYoutube: leagueEntity.value(forKey: "youtube") as! String)
                leagueObjects.append(currentLeague)
            }
            return leagueObjects 
        } catch let error {
            print(error.localizedDescription)
        }
        return [LeagueModel]()
    }
    
    func isFavoriteLague (leagueID: String) -> Bool{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueT")
        
        var predicateLeague = NSPredicate(format: "id == %@", leagueID as! CVarArg)
        fetchRequest.predicate = predicateLeague
        
        do{
            var leagueNSManagedObjects = try viewContext?.fetch(fetchRequest)
            if (leagueNSManagedObjects?.first ?? nil) == nil{
                return false
            }
            return true
        }catch let error as NSError {
            print(error)
        }
        return true
    }
    
    func removeLeague(league: LeagueModel) {
        guard let viewContext = viewContext
        else {return}
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "LeagueT")
        
        var predicateLeague = NSPredicate(format: "id == %@", league.idLeague as! CVarArg)
        fetchRequest.predicate = predicateLeague
        
        do{
            var leagueNSManagedObjects = try viewContext.fetch(fetchRequest)
            if (leagueNSManagedObjects.first ?? nil) != nil{
                viewContext.delete(leagueNSManagedObjects.first!)
                appDelagate?.saveContext()
            }
        }catch let error as NSError {
            print(error)
        }
      
    }
}

    


//
//  FavoriteTableViewController.swift
//  SportsApp
//
//  Created by Mina Kamal on 16.06.22.
//

import UIKit
import CoreData
import SwiftUI

class FavoriteTableViewController: UIViewController {
    
    
    
    @IBOutlet weak var favTableView: UITableView!
    
    @IBOutlet weak var noFavoriteView: UIView!
    
    var favPresenter: FavoritesPresenterProtocol?
    var favLeagues: [LeagueModel]?
    var localDataSource = LocalDataSource.sharedInstance
  
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        favPresenter?.setAppDelegateAndViewContext(appDelagate: appDelegate, viewContext: viewContext)
        
        noFavoriteView.isHidden = false
        
        self.favLeagues = favPresenter?.getFavLeagues()
        
        if  self.favLeagues?.isEmpty ?? true{
            noFavoriteView.isHidden = false
        }else {
            
            noFavoriteView.isHidden = true
            self.favTableView.reloadData()
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favTableView.delegate = self
        favTableView.dataSource = self
        
        favPresenter = FavoritePresenter()
    
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if NetworkConnection.isConnectedToNetwork() {
            let leagueSelected = favLeagues?[indexPath.row]
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let leagueDeatailsVC = storyboard.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as? LeagueDetailsViewController
            guard let
                    leagueDeatailsVC = leagueDeatailsVC else{return}
            let indexPath = favTableView.indexPathForSelectedRow
            leagueDeatailsVC.leagueDetailTitle =  favLeagues?[indexPath?.row ?? 0].strLeague
            leagueDeatailsVC.leagueId = favLeagues?[indexPath?.row ?? 0].idLeague
            
            self.present(leagueDeatailsVC , animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title: "Alert", message: "No Internet Connection", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
        
        
    }
    
}
    
    

   
 
    


extension FavoriteTableViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favLeagues?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        guard
            let favLeagues = favLeagues ,
            let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
                as? FavouriteTableViewCell else {return UITableViewCell()}
        cell.setLeague(league: favLeagues[indexPath.row])
        
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
    //    // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // MARK: - Navigation
   /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? LeagueDetailsViewController {
            let indexPath = favTableView.indexPathForSelectedRow
            destinationVC.leagueDetailTitle =  favLeagues?[indexPath?.row ?? 0].strLeague
            destinationVC.leagueId = favLeagues?[indexPath?.row ?? 0].idLeague
        }
        
    }
    */
    
}



//
//  LeaguesTableViewController.swift
//  SportsApp
//
//  Created by Mina Kamal on 08.06.22.
//

import UIKit
import Kingfisher

class LeaguesTableViewController: UITableViewController {
    
    @IBOutlet weak var titleSportLabel: UINavigationItem!
    
    var leagueTitle: String?
    var dataLeague: DataSource?
    var presenterLeague: LeaguesPresenterProtocol?
    var leagues = [LeagueModel]()
    var youtubePressed: String?
    var indexPathSelected: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleSportLabel.title = leagueTitle
        
        dataLeague = DataSource.sharedInstance
        presenterLeague = LeaguesPresenter(dataLeagues: dataLeague!, leagueVC: self)
        presenterLeague?.getDataLeagues(sportName: leagueTitle ?? "") { countries in
            self.leagues = countries
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func backPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //    @IBAction func youTubePressed(_ sender: UIButton) {
    //        if let url = URL(string: "\(youtubePressed ?? "")") {
    //           UIApplication.shared.open(url, options: [:], completionHandler: nil)
    //       }
    //    }
    // MARK: - Table view data source
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagues.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as? LeagueTableViewCell
        
        // Configure the cell...
        
        
        cell?.setLeague(league: leagues[indexPath.row])
        
        youtubePressed = leagues[indexPath.row].strYoutube
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexPathSelected = indexPath.row
        
    }
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let leagueDetailsVC = segue.destination as? LeagueDetailsViewController {
            let indexPath = self.tableView.indexPathForSelectedRow
            let passed = leagues[indexPath?.row ?? 0].strLeague
            leagueDetailsVC.leagueDetailTitle = passed
            let leagueIDPassed = leagues[indexPath?.row ?? 0].idLeague
            leagueDetailsVC.leagueId = leagueIDPassed
            let selectedLeague = leagues[indexPath?.row ?? 0]
            leagueDetailsVC.selectedLeague = selectedLeague
            
            
        }
    }
    
}

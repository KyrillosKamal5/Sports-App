//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Mina Kamal on 10.06.22.
//

import UIKit
import CoreData


class LeagueDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var leagueNameTitleBar: UINavigationItem!
    
    @IBOutlet weak var upcomingEventCollectionView: UICollectionView!
    @IBOutlet weak var latestResultsCollectionView: UICollectionView!
    @IBOutlet weak var teamCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIBarButtonItem!
    
    var selectedCell: Int?
    var leagues = [LeagueModel]()
    var teams = [Team]()
    var leagueDetailTitle: String?
    var leagueId: String?
    var teamPresenter: TeamProtocol?
    var teamDataSource: TeamsDataProtocol?
    
    var upcomingEvents = [Event]()
    var latestResults = [Event]()
    var latestResultsPresenter: ResultsLatestProtocol?
    var latestResultsDataSource: LatestResultsProtocol?
    var isFavBtnSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        leagueNameTitleBar.title = leagueDetailTitle
        
        upcomingEventCollectionView.delegate = self
        latestResultsCollectionView.delegate = self
        teamCollectionView.delegate = self
        
        upcomingEventCollectionView.dataSource = self
        latestResultsCollectionView.dataSource = self
        teamCollectionView.dataSource = self
        
        
        teamDataSource = DataSource.sharedInstance
        teamPresenter = TeamPresenter(dataTeam: teamDataSource!, leagueVC: self)
        
        teamPresenter?.getTeam(teamName: leagueDetailTitle ?? "", completionHandler: { teams in
            self.teams = teams
            self.teamCollectionView.reloadData()
        })
        
        
        latestResultsDataSource = DataSource.sharedInstance
        latestResultsPresenter = LatestResultsPresenter(latestResultsData: latestResultsDataSource!, latestResultVC: self)
        
        latestResultsPresenter?.getLatest(leagueID: leagueId ?? "", completionHandler: { upcomingEvents,latestResults  in
            self.upcomingEvents = upcomingEvents
            self.latestResults = latestResults
            self.latestResultsCollectionView.reloadData()
            self.upcomingEventCollectionView.reloadData()
        })
        
    }
    
    @IBAction func favActionBtn(_ sender: UIBarButtonItem) {
        
        let image = UIImage(systemName: "heart")
        let imageFilled =  UIImage(systemName: "heart.fill")
            if isFavBtnSelected {
                favBtn.image = image
                isFavBtnSelected = false
            }
            else{
                favBtn.image = imageFilled
                isFavBtnSelected = true
            }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "League", in: viewContext) else {return}
        let league = NSManagedObject(entity: entity, insertInto: viewContext)
        league.setValue("League Title", forKey: "title")
        league.setValue("League Image", forKey: "image")
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? teamDetailsViewController {
            let selectedteam = teams[selectedCell ?? 0]
            destinationVC.selectedTeam = selectedteam
        }
    }
}


// MARK: UICollectionViewDataSource

extension LeagueDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.upcomingEventCollectionView {
            return upcomingEvents.count
        }else if collectionView == self.latestResultsCollectionView{
            return latestResults.count
        }else{
            return teams.count
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1{
            let latestResultsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResultsCell", for: indexPath) as? LatestResultsCollectionViewCell
            latestResultsCell?.setLatestResultObject(event: upcomingEvents[indexPath.row])
            return latestResultsCell ?? UICollectionViewCell()
        }else if collectionView.tag == 2 {
            let teamCell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as? TeamCollectionViewCell
            teamCell?.setTeamObject(team: teams[indexPath.row])
            return teamCell ?? UICollectionViewCell()
        }
        else{
            let upcomingEventCell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingEventCell", for: indexPath) as? UpcomingEventsCollectionViewCell
            upcomingEventCell?.setUpcomingEventObject(upcomingEvent: upcomingEvents[indexPath.row])
            return upcomingEventCell ?? UICollectionViewCell()
        }
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collectionView == self.upcomingEventCollectionView {
            return upcomingEvents.count
        }else if collectionView == self.latestResultsCollectionView{
            return latestResults.count
        }else{
            return teams.count
        }
    }
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        for cell in teamCollectionView.visibleCells {
    //            let indexPath = teamCollectionView.indexPath(for: cell)
    //            selectedCell = indexPath
    //        }
    //    }
}

// MARK: UICollectionViewDelegate


extension LeagueDetailsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        if collectionView.tag == 2{
            selectedCell = indexPath.row
        }
        
        return true
    }
}

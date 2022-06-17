//
//  SportsCollectionViewController.swift
//  SportsApp
//
//  Created by Kyrillos Kamal on 05.06.22.
//

import UIKit
import Kingfisher

protocol HomeProtocol: AnyObject{
    
}


private let reuseIdentifier = "sportCollectionCell"

class SportsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var dataSource: DataSource?
    var sportsHomePresenter: SportsPresenterProtocol?
    var sports = [Sport]()
    var leaguesVC: LeaguesTableViewController?
    var selectedItem: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        sportsHomePresenter?.getSports(completionHandler: { sports in
            self.sports = sports
            self.collectionView.reloadData()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        dataSource = DataSource.sharedInstance
        sportsHomePresenter = SportsHomePresenter(dataSource: dataSource!, sportsVC: self)
        
        
        
        
        
    }
    
  
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        
        // Pass the selected object to the new view controller.
        
        
        if (segue.identifier == "goToLeagues") {
            if let destinationVC = segue.destination as? LeaguesTableViewController {
                let passed = sports[selectedItem!].strSport
                destinationVC.leagueTitle = passed
            }
            
        }
    }
    
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sports.count
    }
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  reuseIdentifier, for: indexPath) as? SportCollectionViewCell
        
        cell?.sportTypeLabel.text = sports[indexPath.row].strSport
        
        addShadowAndRaduisForCell(cell: cell ?? SportCollectionViewCell())
        
        let url = URL(string: "\(sports[indexPath.row].strSportThumb)")
        let processor = DownsamplingImageProcessor(size: (cell?.collectionImageView.bounds.size)!)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        cell?.collectionImageView.kf.indicatorType = .activity
        cell?.collectionImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "football"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        
        return cell ?? UICollectionViewCell()
    }
    
    func addShadowAndRaduisForCell(cell : SportCollectionViewCell){
        cell.contentView.layer.cornerRadius = 10.0
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true;
        
        //           cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.3
        cell.layer.masksToBounds = false;
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
    }
    
    // for add padding
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
    }
    
    // display two items for all rows
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width/2)-5, height: 150)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SportHeaderCollectionReusableView{
            sectionHeader.sectionHeaderlabel.text = "Sports"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        
        selectedItem = indexPath.row
        
        return true
    }
    
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}

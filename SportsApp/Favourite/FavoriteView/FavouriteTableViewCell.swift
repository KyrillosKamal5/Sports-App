//
//  FavouriteTableViewCell.swift
//  SportsApp
//
//  Created by Kyrillos Kamal on 16.06.22.
//

import UIKit
import Kingfisher
class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLeague: UILabel!
    @IBOutlet weak var imageLeague: UIImageView!
    
    
    var leagueVC: LeaguesTableViewController?
    var youtubeUrl: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func youtubeActionBtn(_ sender: UIButton) {
            var url = URL(string:"https://www.apple.com")
            if let youtubeUrl = self.youtubeUrl , !youtubeUrl.isEmpty{
                url = URL(string: "https://\(youtubeUrl)")
            }
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }


    
    func setLeague(league : LeagueModel){
        titleLeague.text = league.strLeague
        
        let url = URL(string: "\(league.strBadge)")
        let processor = DownsamplingImageProcessor(size: (self.bounds.size))
        |> RoundCornerImageProcessor(cornerRadius: 10)
        imageView?.kf.indicatorType = .activity
        imageView?.kf.setImage(
            with: url,
            placeholder: UIImage(named: "football"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        youtubeUrl = league.strYoutube
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

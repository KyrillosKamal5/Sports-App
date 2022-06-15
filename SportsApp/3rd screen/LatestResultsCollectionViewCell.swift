//
//  LatestResultsCollectionViewCell.swift
//  SportsApp
//
//  Created by Mina Kamal on 11.06.22.
//

import UIKit
import Kingfisher

class LatestResultsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var latestImageView: UIImageView!
    
    @IBOutlet weak var homeScoreLabel: UILabel!
    
    @IBOutlet weak var awayScoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    func setLatestResultObject (event: Event) {
        homeScoreLabel.text = event.intHomeScore
        awayScoreLabel.text = event.intAwayScore
        timeLabel.text = event.strTime
        dateLabel.text = event.dateEvent
        
        let url = URL(string: event.strThumb ?? "")
        //(self.bounds.size)
        let size =   CGSize(width: 200, height: 80)
        let processor = DownsamplingImageProcessor(size:
                                                    size)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        latestImageView.kf.indicatorType = .activity
        latestImageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: "football"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
   
}

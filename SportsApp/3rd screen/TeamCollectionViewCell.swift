//
//  TeamCollectionViewCell.swift
//  SportsApp
//
//  Created by Mina Kamal on 11.06.22.
//

import UIKit
import Kingfisher

class TeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    
    func setTeamObject(team: Team){
        
        
        teamNameLabel.text = team.strTeam
        
        let url = URL(string: team.strTeamBadge ?? "")
        //(self.bounds.size)
      var size =   CGSize(width: 50, height: 50)
        let processor = DownsamplingImageProcessor(size:
                                                    size)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        teamImage.kf.indicatorType = .activity
        teamImage.kf.setImage(
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

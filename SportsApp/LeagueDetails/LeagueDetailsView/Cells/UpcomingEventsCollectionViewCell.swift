//
//  UpcomingEventsCollectionViewCell.swift
//  SportsApp
//
//  Created by Kyrillos Kamal on 11.06.22.
//

import UIKit

class UpcomingEventsCollectionViewCell: UICollectionViewCell {
 
   
    @IBOutlet weak var firstTeamLabel: UILabel!
    
    @IBOutlet weak var secondTeamLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    func setUpcomingEventObject(upcomingEvent: Event) {
        
        
        firstTeamLabel.text = upcomingEvent.strHomeTeam
        secondTeamLabel.text = upcomingEvent.strAwayTeam
        dateLabel.text = upcomingEvent.dateEvent
        timeLabel.text = upcomingEvent.strTime
    }
}




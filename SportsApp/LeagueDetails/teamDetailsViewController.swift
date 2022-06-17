//
//  teamDetailsViewController.swift
//  SportsApp
//
//  Created by Kyrillos Kamal on 13.06.22.
//

import UIKit
import Kingfisher


class teamDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var teamTitleBar: UINavigationItem!
    @IBOutlet weak var stadiumImage: UIImageView!
    @IBOutlet weak var teamLogoImage: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var selectedTeam: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func setupView () {
        displayImage(urlImage: selectedTeam?.strTeamBadge ?? "", imageView: teamLogoImage)
        displayImage(urlImage: selectedTeam?.strStadiumThumb ?? "", imageView: stadiumImage)
        teamTitleBar.title = selectedTeam?.strTeam
        teamNameLabel.text = selectedTeam?.strTeam
        yearLabel.text = selectedTeam?.intFormedYear
        countryLabel.text = selectedTeam?.strCountry
        descriptionLabel.text = selectedTeam?.strDescriptionEN
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    private func displayImage(urlImage: String, imageView: UIImageView) {
        let urlImage = URL(string: urlImage)
        //(self.bounds.size)
        let sizeImage =   CGSize(width: 50, height: 50)
        let processorImage = DownsamplingImageProcessor(size: sizeImage)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: urlImage,
            placeholder: UIImage(named: "football"),
            options: [
                .processor(processorImage),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
}

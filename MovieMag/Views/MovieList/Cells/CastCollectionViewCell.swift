//
//  CastCollectionViewCell.swift
//  MovieMag
//
//  Created by pc on 8.06.2022.
//

import UIKit
import Kingfisher

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var actorNameLabel: UILabel!
    
    var cast: Cast?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(cast: Cast) {
        self.cast = cast
        castImageView.kf.setImage(with: cast.profileURL)
        characterNameLabel.text = cast.character
        actorNameLabel.text = cast.original_name
    }
}

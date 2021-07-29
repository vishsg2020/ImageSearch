//
//  ImageListCell.swift
//  ImageSearch
//
//  Created by You on 30/07/21.
//

import UIKit
class ImageListCell: UITableViewCell {

    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageThumbnail: UIImageView!
    
    var item : ImageDataModel? {
        didSet {
            imageTitle.text = item?.imageTitle
            imageThumbnail.image = UIImage(named: "placeHolderImage")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

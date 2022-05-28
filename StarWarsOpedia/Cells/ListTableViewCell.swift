
//  ListTableViewCell.swift
//
//  Created by Jesteena on 28/05/22.
//

import UIKit

class ListTableViewCell: UITableViewCell {

  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var companyNameLabel: UILabel!
  @IBOutlet weak var img: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  
  func Configure(user: UserModel) {
    nameLabel.text = user.name
    companyNameLabel.text = user.company?.name
    img.layer.cornerRadius = img.frame.height / 2
    img.loadFrom(URLAddress: user.profile_image ?? "")

//    if let imageUrl = user.profile_image {
//      img.setImage(url: imageUrl, placeHolder: "")
//}
  }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
//extension UIImageView {
//    func setImage(url: String, placeHolder: String? = "live-PlaceHolder") {
//        if let addUrl = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: addUrl) {
//            UIImageView.af_sharedImageDownloader.imageCache?.removeAllImages()
//            UIImageView.af_sharedImageDownloader.sessionManager.session.configuration.urlCache?.removeAllCachedResponses()
//
//            var placeholderImage = UIImage()
//            if !(placeHolder?.isEmpty ?? false) {
//                placeholderImage = UIImage(named: placeHolder ?? "") ?? UIImage()
//            }
//            self.af_setImage(withURL: url, placeholderImage: placeholderImage, runImageTransitionIfCached: false)
//        } else {
//            self.image = UIImage(named: placeHolder ?? "") ?? UIImage()
//        }
//    }
//}

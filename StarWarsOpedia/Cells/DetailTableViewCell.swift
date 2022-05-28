
//  DetailTableViewCell.swift
//
//  Created by Jesteena on 28/05/22.
//
import UIKit

class DetailTableViewCell: UITableViewCell {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var companyNameLabel: UILabel!
  @IBOutlet weak var img: UIImageView!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var zipCodeLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var companycatchPhraseLabel: UILabel!
  @IBOutlet weak var websiteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func Configure(userDetail: UserModel) {
    nameLabel.text = userDetail.name
    companyNameLabel.text = userDetail.company?.name
    addressLabel.text = userDetail.address?.street
    emailLabel.text = userDetail.email
    userNameLabel.text = userDetail.username
    zipCodeLabel.text = userDetail.address?.zipcode
    phoneLabel.text = userDetail.phone
    companycatchPhraseLabel.text = userDetail.company?.catchPhrase
    img.loadFrom(URLAddress: userDetail.profile_image ?? "")
    websiteLabel.text = userDetail.website

  }
  
  func loadData(profileImag: String) {
    img.loadFrom(URLAddress: profileImag ?? "")

  }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

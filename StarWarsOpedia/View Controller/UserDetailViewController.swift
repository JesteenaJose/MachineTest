//  UserDetailViewController.swift
//
//  Created by Jesteena on 28/05/22.
/// THE SOFTWARE.

import UIKit
import CoreData

class UserDetailViewController: UIViewController {

  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var usernameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var addressnameLabel: UILabel!
  @IBOutlet weak var zipcodeLabel: UILabel!
  @IBOutlet weak var phoneLabel: UILabel!
  @IBOutlet weak var companyNameLabel: UILabel!
  @IBOutlet weak var tableview: UITableView!
  var userList: NSManagedObject?
  var data: UserModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if data != nil {
      
    } else {
     // getAllUserDetail()
    }
    tableview.register(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCell")
  }

}

// MARK: - UITableViewDataSource
extension UserDetailViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as? DetailTableViewCell {
      cell.selectionStyle = .none
      
      if data != nil {
        
        cell.Configure(userDetail: data!)


      } else {
        
        let user = userList
        cell.nameLabel?.text = user?.value(forKeyPath: "name") as? String
        cell.companyNameLabel?.text = user?.value(forKeyPath: "companyName") as? String
        cell.emailLabel?.text = user?.value(forKeyPath: "email") as? String
        cell.addressLabel?.text = user?.value(forKeyPath: "addressName") as? String
        cell.zipCodeLabel?.text = user?.value(forKeyPath: "zipcode") as? String
        cell.phoneLabel?.text = user?.value(forKeyPath: "phone") as? String
        cell.loadData(profileImag:(user?.value(forKeyPath: "profileimage") as? String ?? ""))
        cell.companycatchPhraseLabel?.text = user?.value(forKeyPath: "catchPhrase") as? String
        cell.websiteLabel?.text = user?.value(forKeyPath: "website") as? String
      }
      
         return cell

      }
         return UITableViewCell()

      }
 
    }

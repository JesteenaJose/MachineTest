//  ListViewController.swift
//
//  Created by Jesteena on 28/05/22.
/// THE SOFTWARE.

import UIKit
import Alamofire
import CoreData

class ListViewController: UIViewController {

  var user: [UserModel] = []
  var userList: [NSManagedObject] = []
  var isSearching = false
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    searchBar.delegate = self
    searchBar.returnKeyType = UIReturnKeyType.done

    if userList.count == 0 {
      fetchUserData()
    }  else {
       fetchAllDataFromCoredata()
    }
    tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")
  }
  
  override func viewDidAppear(_ animated: Bool) {
    view.endEditing(true)
  }
  
//   func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//    selectedItem = items[indexPath.row]
//    return indexPath
//  }
//  
//  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    guard let destinationVC = segue.destination as? DetailViewController else {
//      return
//    }
//  //  destinationVC.data = selectedItem
//  }
}

// MARK: - UISearchBarDelegate
extension ListViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    guard let shipName = searchBar.text else { return }

    isSearching = true
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedObjectContext = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    request.predicate = NSPredicate(format: "name CONTAINS[cd] %@", searchBar.text!)

    do {
               userList = try managedObjectContext.fetch(request) as! [NSManagedObject]
      
               if userList.count == 0 {
        
                 isSearching = false
               }
      
           } catch let error as NSError {
               print("Could not fetch. \(error)")
           }

    tableView.reloadData()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchKey = searchBar.text else { return }

    view.endEditing(true)

    isSearching = true
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    let managedObjectContext = appDelegate.persistentContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
    request.predicate = NSPredicate(format: "name CONTAINS[cd] %@","email CONTAINS[cd] %@", searchKey)

    do {
               userList = try managedObjectContext.fetch(request) as! [NSManagedObject]
      
               if userList.count == 0 {
        
                 isSearching = false
               }
      
           } catch let error as NSError {
               print("Could not fetch. \(error)")
           }

      tableView.reloadData()
  }

  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.text = nil
    searchBar.resignFirstResponder()
   // items = films
   // tableView.reloadData()
  }
}

// MARK: - Alamofire
extension ListViewController {
  func fetchUserData() {
    
    AF.request("http://www.mocky.io/v2/5d565297300000680030a986").validate().responseDecodable(of: [UserModel].self) { [self] (response) in
      guard let userData = response.value else { return }
      self.user = userData
      print(self.user.count)
      self.saveUserData()
      self.tableView.reloadData()
    }
  }
  
 
  
  func saveUserData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext

    for item in user {
        do {
          let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext)
          newUser.setValue(item.name, forKey: "name")
          newUser.setValue(item.username, forKey: "username")
          newUser.setValue(item.company?.name, forKey: "companyName")
          newUser.setValue(item.email, forKey: "email")
          newUser.setValue(item.phone, forKey: "phone")
          newUser.setValue(item.website, forKey: "website")
          newUser.setValue(item.company?.catchPhrase, forKey: "catchPhrase")
          newUser.setValue(item.company?.bs, forKey: "bs")
          newUser.setValue(item.address?.street, forKey: "addressName")
          newUser.setValue(item.address?.zipcode, forKey: "zipcode")
          newUser.setValue(item.profile_image, forKey: "profileimage")

            try managedContext.save()
        } catch {
            //do nothing
        }
      }

  
 }
  
  func fetchAllDataFromCoredata(){

    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
      return
    }

    let managedContext = appDelegate.persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")

    do {
      userList = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
      }
  
}
extension ListViewController: UITableViewDataSource {
  
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     if isSearching == true {
       return userList.count

     } else {
       return user.count

     }
  }
  
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
     if let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as? ListTableViewCell {
       
       if isSearching == true {
         let user = userList[indexPath.row]
         cell.nameLabel?.text = user.value(forKeyPath: "name") as? String
         cell.companyNameLabel?.text = user.value(forKeyPath: "companyName") as? String


       } else {
         cell.Configure(user: user[indexPath.row])

       }
         return cell
     }
    return UITableViewCell()
  }
  

}


extension ListViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let newViewController = storyBoard.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
    
    if isSearching == true {
      newViewController.userList = userList[indexPath.row]

    } else {
      newViewController.data = user[indexPath.row]

    }
  navigationController?.pushViewController(newViewController, animated: true)
    
    
 
  

  }
}

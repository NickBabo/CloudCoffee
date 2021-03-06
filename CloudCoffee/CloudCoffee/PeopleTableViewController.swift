//
//  PeopleTableViewController.swift
//  CloudCoffee
//
//  Created by Osniel Lopes Teixeira on 04/10/2017.
//  Copyright © 2017 Nicholas Babo. All rights reserved.
//

import UIKit
import CloudKit

class PeopleTableViewController: UITableViewController {
    
    var people = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return people.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pessoa", for: indexPath)
        
        // Configure the cell...
        
        if let person = cell as? NameTableViewCell {
            person.nameLabel.text = people[indexPath.row]
            return person
        }
        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateDataSource()
    }
    
    private func updateDataSource() {
        let publicData = CKContainer.default().publicCloudDatabase
        let query = CKQuery(recordType: "Coffee", predicate: NSPredicate(value: true))
        //query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        publicData.perform(query, inZoneWith: nil) { (results, error) in
            
            guard let safeResults = results, error == nil else {
                print("Problemas")
                print(error.debugDescription)
                return
            }
            
            for result in safeResults {
                let resultOwner = result.object(forKey: "owner") as? String ?? "Aquele-que-não-deve-ser-nomeado"
                if !self.people.contains(resultOwner) {
                    self.people.append(resultOwner)
                }
            }
            
            self.people = self.people.sorted()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMyCoffeesFromExplore", sender: people[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMyCoffeesFromExplore" {
            if let deest = segue.destination as? MyCoffeeTableViewController{
                deest.selectedPerson = sender as? String
                deest.navigationItem.title = (sender as? String)! + " Coffees"
                deest.navigationItem.rightBarButtonItem = UIBarButtonItem()
            }
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

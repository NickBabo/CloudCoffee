//
//  MyCoffeeTableViewController.swift
//  CloudCoffee
//
//  Created by Nicholas Babo on 04/10/17.
//  Copyright © 2017 Nicholas Babo. All rights reserved.
//

import UIKit
import CloudKit

class MyCoffeeTableViewController: UITableViewController {
    
    var myCoffees = [CKRecord]()

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        loadData()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func isAppAlreadyLaunchedOnce() {
        let defaults = UserDefaults.standard
        
        if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil{
            
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            
            let alert = UIAlertController(title: "Nome", message: "Qual é o seu nome?", preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (textField) in
                textField.placeholder = "Seu Nome"
            })
            alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { (action) in
                let field = alert.textFields?.first
                defaults.set(field?.text, forKey: "userToken")
            }))
            
        }
    }
    
    func loadData(){
        self.myCoffees = [CKRecord]()
        
        let publicData = CKContainer.default().publicCloudDatabase
        let query = CKQuery(recordType: "Coffee", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        publicData.perform(query, inZoneWith: nil) { (results, error) in
            if let coffees = results{
                self.myCoffees = coffees
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.myCoffees.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeCell", for: indexPath) as! CoffeeTableViewCell
        
        cell.coffeNameLabel.text = self.myCoffees[indexPath.row].object(forKey: "name") as? String
        cell.placeLabel.text = self.myCoffees[indexPath.row].object(forKey: "place") as? String
        cell.priceLabel.text = self.myCoffees[indexPath.row].object(forKey: "price") as? String
        cell.ratingLabel.text = self.myCoffees[indexPath.row].object(forKey: "stars") as? String

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
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
//
//  NewCoffeeTableViewController.swift
//  CloudCoffee
//
//  Created by Nicholas Babo on 04/10/17.
//  Copyright © 2017 Nicholas Babo. All rights reserved.
//

import UIKit
import CloudKit

class NewCoffeeTableViewController: UITableViewController {
    
    @IBOutlet weak var outletCoffeeName: UITextField!
    
    @IBOutlet weak var outletPlace: UITextField!
    
    @IBOutlet weak var outletPrice: UITextField!
    
    @IBOutlet weak var outletStars: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        return 4
    }
    
    @IBAction func saveCoffee(_ sender: Any) {
        
        let newCoffee = CKRecord(recordType: "Coffee")
        newCoffee["name"] = self.outletCoffeeName.text as CKRecordValue?
        newCoffee["place"] = self.outletPlace.text! as CKRecordValue
        newCoffee["price"] = self.outletPrice.text as CKRecordValue?
        newCoffee["stars"] = self.outletStars.text! as CKRecordValue
        newCoffee["owner"] = UserDefaults.standard.string(forKey: "userToken") as CKRecordValue?
        
        let publicData = CKContainer.default().publicCloudDatabase
        publicData.save(newCoffee) { (record, error) in
            if error == nil{
                print("saved coffee!")
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

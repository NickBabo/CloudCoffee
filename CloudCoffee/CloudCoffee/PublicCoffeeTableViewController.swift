//
//  PublicCoffeeTableViewController.swift
//  CloudCoffee
//
//  Created by Nicholas Babo on 04/10/17.
//  Copyright © 2017 Nicholas Babo. All rights reserved.
//

import UIKit
import CloudKit

class PublicCoffeeTableViewController: UITableViewController {
    
    var people = [CKRecord]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        self.tableView.reloadData()
    }
    
    func loadData(){
        self.people = [CKRecord]()
        
        let publicData = CKContainer.default().publicCloudDatabase
        let query = CKQuery(recordType: "People", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        publicData.perform(query, inZoneWith: nil) { (results, error) in
            if let people = results{
                self.people = people
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func addCoisa(){
        let alert = UIAlertController(title: "New Sweet", message: "Enter a Sweet", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Your Sweet"
        }
        
        alert.addAction(UIAlertAction(title: "Send", style: .default, handler: { (action) in
            let field = alert.textFields?.first!
            
            if field?.text != ""{
                let newSweet = CKRecord(recordType: "Sweet")
                newSweet["content"] = field?.text! as CKRecordValue?
                
                let publicData = CKContainer.default().publicCloudDatabase
                publicData.save(newSweet, completionHandler: { (record, error) in
                    if error == nil{
                        print("sweet saved")
                    }
                })
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count
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

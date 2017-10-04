//
//  PublicCoffeeListViewController.swift
//  CloudCoffee
//
//  Created by Nicholas Babo on 04/10/17.
//  Copyright © 2017 Nicholas Babo. All rights reserved.
//

import UIKit
import CloudKit

class PublicCoffeeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var publicCoffeeList = [CKRecord]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        self.publicCoffeeList = [CKRecord]()
        
        let publicData = CKContainer.default().publicCloudDatabase
        let query = CKQuery(recordType: "Coffee", predicate: NSPredicate(format: "TRUEPREDICATE", argumentArray: nil))
        
        publicData.perform(query, inZoneWith: nil) { (results, error) in
            if let coffees = results{
                self.publicCoffeeList = coffees
                
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    @IBAction func clickButton(_ sender: Any) {
        
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
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

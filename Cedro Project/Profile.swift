//
//  Profile.swift
//  Cedro Project
//
//  Created by Rafael Cunha de Oliveira on 31/01/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class Profile: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var firstnameLabel: UITextField!
    @IBOutlet weak var lastnameLabel: UITextField!
    @IBOutlet weak var addressLabel: UITextField!
    var rusername = String()
    var rFirstName = String()
    var rLastName = String()
    var rAddress = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    if rusername == result.value(forKey: "username") as! String {
                        let userName = rusername
                        rusername = String (describing: userName)
                        print (userName)
                        usernameLabel.text = rusername
                        if let firstName = result.value(forKey: "firstname") {
                            
                            rFirstName = String (describing: firstName)
                            print (firstName)
                            firstnameLabel.text = rFirstName
                        }
                        if let lastname = result.value(forKey: "lastname"){
                            print (lastname)
                            rLastName = String (describing: lastname)
                            lastnameLabel.text = rLastName
                        }
                        if let address = result.value(forKey: "address"){
                            print (address)
                            rAddress = String (describing: address)
                            addressLabel.text = rAddress
                        }
                        break
                    }

                    
                }
            }
            
        }
        catch{
            //error
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

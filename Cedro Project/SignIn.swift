//
//  SignIn.swift
//  Cedro Project
//
//  Created by Rafael Cunha de Oliveira on 31/01/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class SignIn: UIViewController {

    @IBOutlet weak var userLabel: UITextField!
    
    @IBOutlet weak var passLabel: UITextField!
    
    @IBOutlet weak var firstNameLabel: UITextField!
    
    @IBOutlet weak var lastNameLabel: UITextField!
    
    @IBOutlet weak var addressLabel: UITextField!
    
    var userNameValue: String = ""
    var passValue: String = " "
    var firstNameValue: String = ""
    var lastNameValue: String = " "
    var addressValue: String = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }
    @IBAction func SaveButton(_ sender: Any) {
        userNameValue = userLabel.text!
        passValue = passLabel.text!
        firstNameValue = firstNameLabel.text!
        lastNameValue = lastNameLabel.text!
        addressValue = addressLabel.text!
        if(userNameValue == "" || passValue == "" || firstNameValue == "" || lastNameValue == "" || addressValue == ""){
            let alert = UIAlertController(title: "Missing information needed", message: "Please, fill all the fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                
                
                var newUser = true
                if results.count > 0{
                    for result in results as! [NSManagedObject]{
                        if userNameValue == result.value(forKey: "username") as! String{
                            let alertError = UIAlertController(title: "User already signed in", message: "Please, choose another username", preferredStyle: UIAlertControllerStyle.alert)
                            alertError.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                            self.present(alertError, animated: true, completion: nil)
                            newUser = false
                            break
                        }
                        
                    }
                    if(newUser == true){
                        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
                        
                        newUser.setValue(userNameValue, forKey: "username")
                        newUser.setValue(passValue, forKey: "password")
                        newUser.setValue(firstNameValue, forKey: "firstname")
                        newUser.setValue(lastNameValue, forKey: "lastname")
                        newUser.setValue(addressValue, forKey: "address")
                        
                        
                        do{
                            try context.save()
                            print("The user is saved")
                            
                            self.performSegue(withIdentifier: "SignInAcc", sender: userNameValue)
                            
                        }
                    }
                }
                
            }
            
        }
        catch{
            //error
        }
    }


    
//    func storage(un: String, ps: String, fn: String, ln: String, ad: String){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        let context = appDelegate.persistentContainer.viewContext
//        
//        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
//        
//        newUser.setValue(fn, forKey: "username")
//        newUser.setValue(ps, forKey: "password")
//        newUser.setValue(fn, forKey: "firstname")
//        newUser.setValue(ln, forKey: "lastname")
//        newUser.setValue(ad, forKey: "address")
//        
//        
//        do{
//            try context.save()
//            print("The user is saved")
//            
//        }
//        catch{
//            //error
//        }
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SignInAcc"{
            print("aqui \(segue.destination)")
            let DestViewController = segue.destination as! UINavigationController
            let targetController = DestViewController.topViewController as! Profile
            targetController.rusername = (sender as! String)
            //           print(sender)
            
        }
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

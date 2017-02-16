//
//  Login.swift
//  Cedro Project
//
//  Created by Rafael Cunha de Oliveira on 31/01/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class Login: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passUserName: UIButton!
    

    var user: String = ""
    var pass: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func LoginB(_ sender: Any) {
        user = userName.text!
        pass = password.text!
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                
                
                
                if results.count > 0{
                    for result in results as! [NSManagedObject]{
                        if user == result.value(forKey: "username") as! String{
                            if pass == result.value(forKey: "password") as! String{
                                self.performSegue(withIdentifier: "loginAcc", sender: user)
                                
                            }
                            else{
                                let alertPass = UIAlertController(title: "Wrong Password", message: "Please, type again", preferredStyle: UIAlertControllerStyle.alert)
                                alertPass.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                                self.present(alertPass, animated: true, completion: nil)
                            }
                        }
                        
                    }
                    let alertUser = UIAlertController(title: "The UserName does not exist", message: "Please, sign in", preferredStyle: UIAlertControllerStyle.alert)
                    alertUser.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alertUser, animated: true, completion: nil)
                }
                
            }
            
        }
        catch{
            //error
        }

    }

    
//    @IBAction func loginButton(_ sender: Any) {
//        user = userName.text!
//        pass = password.text!
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        
//        let context = appDelegate.persistentContainer.viewContext
//        
//        
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
//        
//        request.returnsObjectsAsFaults = false
//        
//        do{
//            let results = try context.fetch(request)
//            if results.count > 0{
//                
//                
//
//                if results.count > 0{
//                    for result in results as! [NSManagedObject]{
//                        if user == result.value(forKey: "username") as! String{
//                            if pass == result.value(forKey: "shortName") as! String{
//
//                                loginButton.addTarget(self, action: #selector(enterSystem), for: .touchUpInside)
//                            }
//                            else{
//                                let alertPass = UIAlertController(title: "Wrong Password", message: "Please, type again", preferredStyle: UIAlertControllerStyle.alert)
//                                alertPass.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                                self.present(alertPass, animated: true, completion: nil)
//                            }
//                        }else{
//                            let alertUser = UIAlertController(title: "The UserName does not exist", message: "Please, sign in", preferredStyle: UIAlertControllerStyle.alert)
//                            alertUser.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
//                            self.present(alertUser, animated: true, completion: nil)
//                        }
//    
//                        
//                    }
//                }
//                
//            }
//            
//        }
//        catch{
//            //error
//        }
    
//    }
//    func enterSystem(sender: UIButton){
//        self.performSegue(withIdentifier: "logAccept", sender: sender)
//    }
//    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginAcc"{
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

//
//  IndividualCountry.swift
//  Cedro Project
//
//  Created by Rafael Cunha de Oliveira on 30/01/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class IndividualCountry: UIViewController {
    

    
    @IBOutlet weak var CountryFlag: UIImageView!
    
    @IBOutlet weak var shortNameLabel: UILabel!
    
    @IBOutlet weak var longNameLabel: UILabel!
    
    @IBOutlet weak var callingCodeLabel: UILabel!
    
    @IBOutlet weak var switchVisited: UISwitch!
    
    @IBOutlet weak var date: UITextField!
    
    var saveCountryId: NSNumber = 0.0
    
    var cFlag: UIImage!
    var id: String!
    var shortNameVar: String!
    var longNameVar: String!
    var callingCodeVar: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.shortNameLabel.text = shortNameVar
        self.longNameLabel.text = longNameVar
        self.callingCodeLabel.text = callingCodeVar
        self.CountryFlag.image = cFlag

    }
    @IBAction func Save(_ sender: UIButton) {
        if switchVisited.isOn{
            if(date.text != nil){
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                
                let context = appDelegate.persistentContainer.viewContext
                
                let idCountry: String = saveCountryId.stringValue

                
                let newUser_Country = NSEntityDescription.insertNewObject(forEntityName: "User_Country", into: context)
                
                newUser_Country.setValue("rafael", forKey: "username")
                newUser_Country.setValue(idCountry, forKey: "id")
                newUser_Country.setValue(date.text, forKey: "date")
                
                let newCountry = NSEntityDescription.insertNewObject(forEntityName: "Country", into: context)
                newCountry.setValue(callingCodeVar, forKey: "code")
                newCountry.setValue(idCountry, forKey: "id")
                newCountry.setValue(shortNameVar, forKey: "shortName")
                newCountry.setValue(longNameVar, forKey: "longName")
                
                do{
                    try context.save()
                    print("The user is saved")
                    
                }
                catch{
                    //error
                }
                
                
            }
            else{
                let dateAlert = UIAlertController(title: "When did you go there?", message: "You forgot to enter the date", preferredStyle: UIAlertControllerStyle.alert)
                dateAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(dateAlert, animated: true, completion: nil)
            }
        }
        else{
            let alert = UIAlertController(title: "Have not visted yet?", message: "You should try, it's a very nice place", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    
//    func store(){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let context = appDelegate.persistentContainer.viewContext
//        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: context)
//        
//        newUser.setValue("rafael", forKey: "username")
//        newUser.setValue("123", forKey: "password")
//        newUser.setValue("Rafael", forKey: "firstname")
//        newUser.setValue("Cunha", forKey: "lastname")
//        newUser.setValue("Rua Professor Olimpio", forKey: "address")
//        newUser.setValue(38315234, forKey: "phone")
//        
//        do{
//            try context.save()
//            print("The user is saved")
//            
//        }
//        catch{
//            //error
//        }
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}



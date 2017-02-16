//
//  IndividualCountry.swift
//  Cedro Project
//
//  Created by Rafael Cunha de Oliveira on 30/01/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class IndividualVisitedCountry: UIViewController {
    
    
    
    @IBOutlet weak var CountryFlag: UIImageView!
    @IBOutlet weak var shortNameLabel: UILabel!
    @IBOutlet weak var longNameLabel: UILabel!
    @IBOutlet weak var callingCodeLabel: UILabel!
    
    var id: String!
    var shortNameVar: String!
    var longNameVar: String!
    var callingCodeVar: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let idC = id as String
        let urlFlag: String = "http://sslapidev.mypush.com.br/world/countries/\(idC)/flag"
        let urlRequestFlag = URL(string: urlFlag)
        
        let flagPic = NSData(contentsOf: urlRequestFlag!)
        let image = UIImage(data: flagPic as! Data)
        if image != nil{
            print("works")
        }
        
        self.CountryFlag.image = image
        self.shortNameLabel.text = shortNameVar
        self.longNameLabel.text = longNameVar
        self.callingCodeLabel.text = callingCodeVar
    
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}



//
//  CList.swift
//  Cedro Project
//
//  Created by Rafael Cunha de Oliveira on 30/01/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class CList: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    
    @IBOutlet weak var collectionView: UICollectionView!
    struct countries {
        var id: NSNumber
        var countryFlag: URL
        var shortName: String
        var longName: String
        var callingCode: String
    }
    
    var listData = [[String: AnyObject]]()
    var listImages = [URL]()
    
    var countryArray: [countries] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        countryArray.append(countries(id: "1", shortName: "Br", longName: "Brazil", callingCode: "211"))
//        countryArray.append(countries(id: "2", shortName: "Al", longName: "Alemanha", callingCode: "311"))
        
        let url: String = "http://sslapidev.mypush.com.br/world/countries/active"
        let urlRequest = URL(string: url)
        
//        let urlFlag: String = "http://sslapidev.mypush.com.br/world/countries/392/flag"
//        let urlRequestFlag = URL(string: urlFlag)
//        
//        let flagPic = NSData(contentsOf: urlRequestFlag!)
//        let image = UIImage(data: flagPic as! Data)
//        if image != nil{
//            print("works!")
//        }
        
        
        URLSession.shared.dataTask(with: urlRequest!, completionHandler: {
            (data, response, error) in
            if(error != nil){
                print(error.debugDescription)
            }else{
                do{
                    self.listData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        as! [[String: AnyObject]]
                    
                    self.collectionView?.reloadData()
                    
                }catch let error as NSError{
                    print(error)
                }
            }

            for data in self.listData{
                let idC : String = data["id"]!.stringValue
                let urlFlag: String = "http://sslapidev.mypush.com.br/world/countries/\(idC)/flag"
                let urlRequestFlag = URL(string: urlFlag)
                print("Aqui")
                
//                let flagPic = NSData(contentsOf: urlRequestFlag!)
//                let image = UIImage(data: flagPic as! Data)
//                if image != nil{
//                    print("works")
                    self.countryArray.append(countries(id: data["id"] as! NSNumber, countryFlag: urlRequestFlag!, shortName: data["shortname"] as! String, longName: data["longname"] as! String, callingCode: data["callingCode"] as! String))
//                }

            }
            
        }).resume()
        


        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tamanho = countryArray.count
        return tamanho
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! ManageCell
        cell.name.text = countryArray[indexPath.item].shortName
//        cell.flag.image = countryArray[indexPath.item].countryFlag
        cell.flag.sd_setImage(with: countryArray[indexPath.item].countryFlag)
        cell.details.tag = indexPath.item
        cell.details.addTarget(self, action: #selector(didGoToIndCountry), for: .touchUpInside)
        return cell
        
    }
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didGoToIndCountry(sender: UIButton){
        self.performSegue(withIdentifier: "toCountryIndividual", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCountryIndividual" {

            let sender = sender as! UIButton
            let countryVC  = segue.destination as! IndividualCountry
            let flagPic = NSData(contentsOf: countryArray[sender.tag].countryFlag)
            let image = UIImage(data: flagPic as! Data)
            if image != nil{
                print("works")
            }
            countryVC.saveCountryId = countryArray[sender.tag].id
            countryVC.cFlag = image
            countryVC.shortNameVar = countryArray[sender.tag].shortName
            countryVC.longNameVar = countryArray[sender.tag].longName
            countryVC.callingCodeVar = countryArray[sender.tag].callingCode
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

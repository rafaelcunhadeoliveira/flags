import UIKit
import CoreData



class HaveVisited: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    @IBOutlet weak var collectionView: UICollectionView!
    struct countries {
        var id: String
//        var countryFlag: UIImage
        var shortName: String
        var longName: String
        var callingCode: String
    }
    
    var rid: String = ""
    var rshortName: String = ""
    var rlongName: String = ""
    var rcallingCode: String = ""

    var idList:[String] = []
    var countryArray: [countries] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User_Country")
        
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(request)
            if results.count > 0{
                for result in results as! [NSManagedObject]{
                    if  "rafael" == result.value(forKey: "username") as! String {
                        idList.append(result.value(forKey: "id") as! String)
                    }
                }
            }
            let requestCountry = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
            requestCountry.returnsObjectsAsFaults = false
            
            let resultsCountry = try context.fetch(requestCountry)
            if resultsCountry.count > 0{
                for resultCountry in resultsCountry as! [NSManagedObject]{
                    if let id = resultCountry.value(forKey: "id") {
                        rid = String (describing: id)
                        print (id)
                    }
                    if let ShortName = resultCountry.value(forKey: "shortName") {
                        rshortName = String (describing: ShortName)
                        print (rshortName)
                    }
                    if let LongName = resultCountry.value(forKey: "longName"){
                        print (LongName)
                        rlongName = String (describing: LongName)
                    }
                    if let Code = resultCountry.value(forKey: "code"){
                        print (Code)
                        rcallingCode = String (describing: Code)
                    }
                    self.countryArray.append(countries(id: rid, shortName:  rshortName, longName: rlongName, callingCode: rcallingCode))

                }
            }
            

            
        }
        catch{
            //error
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellVisited", for: indexPath) as! ManageCellVisited
        cell.shortName.text = countryArray[indexPath.item].shortName
        cell.longName.text = countryArray[indexPath.item].longName
        cell.code.text = countryArray[indexPath.item].callingCode
        cell.details.tag = indexPath.item
        cell.details.addTarget(self, action: #selector(didGoToIndCountry), for: .touchUpInside)
        return cell
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didGoToIndCountry(sender: UIButton){
        self.performSegue(withIdentifier: "visitedtoCountryInd", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "visitedtoCountryInd" {
            let sender = sender as! UIButton
            let countryVC  = segue.destination as! IndividualVisitedCountry
            countryVC.id = countryArray[sender.tag].id as! String
//            countryVC.cFlag = countryArray[sender.tag].countryFlag
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

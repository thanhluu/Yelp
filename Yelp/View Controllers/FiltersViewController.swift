//
//  FiltersViewController.swift
//  Yelp
//
//  Created by Luu Tien Thanh on 2/22/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit

enum TableSection: Int {
    case deals = 0, distance, sort, categories
}

@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewControllerDidUpdate(_ filtersViewController: FiltersViewController)
}

class FiltersViewController: UIViewController {
    fileprivate func yelpDistances() -> [[String:AnyObject]] {
        let milesPerMeter = 1/0.000621371
        return [["name": "Auto" as AnyObject, "meters" : maxDistance as AnyObject],
                ["name": "0.3 miles" as AnyObject, "meters" : 0.3 * milesPerMeter as AnyObject],
                ["name": "1 mile" as AnyObject, "meters" : 1 * milesPerMeter as AnyObject],
                ["name": "5 miles" as AnyObject, "meters" : 5 * milesPerMeter as AnyObject],
                ["name": "20 miles" as AnyObject, "meters" : 20 * milesPerMeter as AnyObject]]
    }
    var distances: [[String:AnyObject]]!
    
    fileprivate func yelpSorts() -> [[String:AnyObject]] {
        return [["name": "Best Matched" as AnyObject, "sort": YelpSortMode.bestMatched as AnyObject],
                ["name": "Distance" as AnyObject, "sort": YelpSortMode.distance as AnyObject],
                ["name": "Highest Rated" as AnyObject, "sort": YelpSortMode.highestRated as AnyObject]]
    }
    var sorts: [[String:AnyObject]]!

    let categories: [[String: String]] =
        [["name" : "Afghan", "code": "afghani"],
         ["name" : "African", "code": "african"],
         ["name" : "American, New", "code": "newamerican"],
         ["name" : "American, Traditional", "code": "tradamerican"],
         ["name" : "Arabian", "code": "arabian"],
         ["name" : "Argentine", "code": "argentine"],
         ["name" : "Armenian", "code": "armenian"],
         ["name" : "Asian Fusion", "code": "asianfusion"],
         ["name" : "Asturian", "code": "asturian"],
         ["name" : "Australian", "code": "australian"],
         ["name" : "Austrian", "code": "austrian"],
         ["name" : "Baguettes", "code": "baguettes"],
         ["name" : "Bangladeshi", "code": "bangladeshi"],
         ["name" : "Barbeque", "code": "bbq"],
         ["name" : "Basque", "code": "basque"],
         ["name" : "Bavarian", "code": "bavarian"],
         ["name" : "Beer Garden", "code": "beergarden"],
         ["name" : "Beer Hall", "code": "beerhall"],
         ["name" : "Beisl", "code": "beisl"],
         ["name" : "Belgian", "code": "belgian"],
         ["name" : "Bistros", "code": "bistros"],
         ["name" : "Black Sea", "code": "blacksea"],
         ["name" : "Brasseries", "code": "brasseries"],
         ["name" : "Brazilian", "code": "brazilian"],
         ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
         ["name" : "British", "code": "british"],
         ["name" : "Buffets", "code": "buffets"],
         ["name" : "Bulgarian", "code": "bulgarian"],
         ["name" : "Burgers", "code": "burgers"],
         ["name" : "Burmese", "code": "burmese"],
         ["name" : "Cafes", "code": "cafes"],
         ["name" : "Cafeteria", "code": "cafeteria"],
         ["name" : "Cajun/Creole", "code": "cajun"],
         ["name" : "Cambodian", "code": "cambodian"],
         ["name" : "Canadian", "code": "New)"],
         ["name" : "Canteen", "code": "canteen"],
         ["name" : "Caribbean", "code": "caribbean"],
         ["name" : "Catalan", "code": "catalan"],
         ["name" : "Chech", "code": "chech"],
         ["name" : "Cheesesteaks", "code": "cheesesteaks"],
         ["name" : "Chicken Shop", "code": "chickenshop"],
         ["name" : "Chicken Wings", "code": "chicken_wings"],
         ["name" : "Chilean", "code": "chilean"],
         ["name" : "Chinese", "code": "chinese"],
         ["name" : "Comfort Food", "code": "comfortfood"],
         ["name" : "Corsican", "code": "corsican"],
         ["name" : "Creperies", "code": "creperies"],
         ["name" : "Cuban", "code": "cuban"],
         ["name" : "Curry Sausage", "code": "currysausage"],
         ["name" : "Cypriot", "code": "cypriot"],
         ["name" : "Czech", "code": "czech"],
         ["name" : "Czech/Slovakian", "code": "czechslovakian"],
         ["name" : "Danish", "code": "danish"],
         ["name" : "Delis", "code": "delis"],
         ["name" : "Diners", "code": "diners"],
         ["name" : "Dumplings", "code": "dumplings"],
         ["name" : "Eastern European", "code": "eastern_european"],
         ["name" : "Ethiopian", "code": "ethiopian"],
         ["name" : "Fast Food", "code": "hotdogs"],
         ["name" : "Filipino", "code": "filipino"],
         ["name" : "Fish & Chips", "code": "fishnchips"],
         ["name" : "Fondue", "code": "fondue"],
         ["name" : "Food Court", "code": "food_court"],
         ["name" : "Food Stands", "code": "foodstands"],
         ["name" : "French", "code": "french"],
         ["name" : "French Southwest", "code": "sud_ouest"],
         ["name" : "Galician", "code": "galician"],
         ["name" : "Gastropubs", "code": "gastropubs"],
         ["name" : "Georgian", "code": "georgian"],
         ["name" : "German", "code": "german"],
         ["name" : "Giblets", "code": "giblets"],
         ["name" : "Gluten-Free", "code": "gluten_free"],
         ["name" : "Greek", "code": "greek"],
         ["name" : "Halal", "code": "halal"],
         ["name" : "Hawaiian", "code": "hawaiian"],
         ["name" : "Heuriger", "code": "heuriger"],
         ["name" : "Himalayan/Nepalese", "code": "himalayan"],
         ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
         ["name" : "Hot Dogs", "code": "hotdog"],
         ["name" : "Hot Pot", "code": "hotpot"],
         ["name" : "Hungarian", "code": "hungarian"],
         ["name" : "Iberian", "code": "iberian"],
         ["name" : "Indian", "code": "indpak"],
         ["name" : "Indonesian", "code": "indonesian"],
         ["name" : "International", "code": "international"],
         ["name" : "Irish", "code": "irish"],
         ["name" : "Island Pub", "code": "island_pub"],
         ["name" : "Israeli", "code": "israeli"],
         ["name" : "Italian", "code": "italian"],
         ["name" : "Japanese", "code": "japanese"],
         ["name" : "Jewish", "code": "jewish"],
         ["name" : "Kebab", "code": "kebab"],
         ["name" : "Korean", "code": "korean"],
         ["name" : "Kosher", "code": "kosher"],
         ["name" : "Kurdish", "code": "kurdish"],
         ["name" : "Laos", "code": "laos"],
         ["name" : "Laotian", "code": "laotian"],
         ["name" : "Latin American", "code": "latin"],
         ["name" : "Live/Raw Food", "code": "raw_food"],
         ["name" : "Lyonnais", "code": "lyonnais"],
         ["name" : "Malaysian", "code": "malaysian"],
         ["name" : "Meatballs", "code": "meatballs"],
         ["name" : "Mediterranean", "code": "mediterranean"],
         ["name" : "Mexican", "code": "mexican"],
         ["name" : "Middle Eastern", "code": "mideastern"],
         ["name" : "Milk Bars", "code": "milkbars"],
         ["name" : "Modern Australian", "code": "modern_australian"],
         ["name" : "Modern European", "code": "modern_european"],
         ["name" : "Mongolian", "code": "mongolian"],
         ["name" : "Moroccan", "code": "moroccan"],
         ["name" : "New Zealand", "code": "newzealand"],
         ["name" : "Night Food", "code": "nightfood"],
         ["name" : "Norcinerie", "code": "norcinerie"],
         ["name" : "Open Sandwiches", "code": "opensandwiches"],
         ["name" : "Oriental", "code": "oriental"],
         ["name" : "Pakistani", "code": "pakistani"],
         ["name" : "Parent Cafes", "code": "eltern_cafes"],
         ["name" : "Parma", "code": "parma"],
         ["name" : "Persian/Iranian", "code": "persian"],
         ["name" : "Peruvian", "code": "peruvian"],
         ["name" : "Pita", "code": "pita"],
         ["name" : "Pizza", "code": "pizza"],
         ["name" : "Polish", "code": "polish"],
         ["name" : "Portuguese", "code": "portuguese"],
         ["name" : "Potatoes", "code": "potatoes"],
         ["name" : "Poutineries", "code": "poutineries"],
         ["name" : "Pub Food", "code": "pubfood"],
         ["name" : "Rice", "code": "riceshop"],
         ["name" : "Romanian", "code": "romanian"],
         ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
         ["name" : "Rumanian", "code": "rumanian"],
         ["name" : "Russian", "code": "russian"],
         ["name" : "Salad", "code": "salad"],
         ["name" : "Sandwiches", "code": "sandwiches"],
         ["name" : "Scandinavian", "code": "scandinavian"],
         ["name" : "Scottish", "code": "scottish"],
         ["name" : "Seafood", "code": "seafood"],
         ["name" : "Serbo Croatian", "code": "serbocroatian"],
         ["name" : "Signature Cuisine", "code": "signature_cuisine"],
         ["name" : "Singaporean", "code": "singaporean"],
         ["name" : "Slovakian", "code": "slovakian"],
         ["name" : "Soul Food", "code": "soulfood"],
         ["name" : "Soup", "code": "soup"],
         ["name" : "Southern", "code": "southern"],
         ["name" : "Spanish", "code": "spanish"],
         ["name" : "Steakhouses", "code": "steak"],
         ["name" : "Sushi Bars", "code": "sushi"],
         ["name" : "Swabian", "code": "swabian"],
         ["name" : "Swedish", "code": "swedish"],
         ["name" : "Swiss Food", "code": "swissfood"],
         ["name" : "Tabernas", "code": "tabernas"],
         ["name" : "Taiwanese", "code": "taiwanese"],
         ["name" : "Tapas Bars", "code": "tapas"],
         ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
         ["name" : "Tex-Mex", "code": "tex-mex"],
         ["name" : "Thai", "code": "thai"],
         ["name" : "Traditional Norwegian", "code": "norwegian"],
         ["name" : "Traditional Swedish", "code": "traditional_swedish"],
         ["name" : "Trattorie", "code": "trattorie"],
         ["name" : "Turkish", "code": "turkish"],
         ["name" : "Ukrainian", "code": "ukrainian"],
         ["name" : "Uzbek", "code": "uzbek"],
         ["name" : "Vegan", "code": "vegan"],
         ["name" : "Vegetarian", "code": "vegetarian"],
         ["name" : "Venison", "code": "venison"],
         ["name" : "Vietnamese", "code": "vietnamese"],
         ["name" : "Wok", "code": "wok"],
         ["name" : "Wraps", "code": "wraps"],
         ["name" : "Yugoslav", "code": "yugoslav"]]
    
    var delegate: FiltersViewControllerDelegate!
    var selectedDeals: Bool = false
    var selectedCategory = [String]()

    var categoryStates = [Int: Bool]()
    
    var distanceOn = false
    var selectedDistance = maxDistance
    
    var sortOn = false
    var selectedSort = YelpSortMode.bestMatched
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        distances = yelpDistances()
        sorts = yelpSorts()
        
        selectedDistance = BusinessFilterSettings.sharedInstance.distance ?? maxDistance
        distanceOn = selectedDistance != maxDistance
        
        selectedSort = BusinessFilterSettings.sharedInstance.sort ?? YelpSortMode.bestMatched
        sortOn = selectedSort != YelpSortMode.bestMatched
        
        selectedDeals = BusinessFilterSettings.sharedInstance.deals ?? false
        selectedCategory = BusinessFilterSettings.sharedInstance.categories
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onSave(_ sender: Any) {
        // Deals
        BusinessFilterSettings.sharedInstance.deals = selectedDeals
        
        // Distance
        BusinessFilterSettings.sharedInstance.distance = distanceOn ? selectedDistance : maxDistance
        
        // Sort
        BusinessFilterSettings.sharedInstance.sort = sortOn ? selectedSort : YelpSortMode.bestMatched
        
        // Categories
        for (row, isSelected) in categoryStates {
            if isSelected {
                selectedCategory.append(categories[row]["code"]!)
            } else {
                if let index = selectedCategory.index(of: categories[row]["code"]!) {
                    selectedCategory.remove(at: index)
                }
            }
        }
        if selectedCategory.count > 0 {
            BusinessFilterSettings.sharedInstance.categories = selectedCategory
        }
        
        delegate?.filtersViewControllerDidUpdate?(self)
        
        dismiss(animated: true, completion: nil)
    }
}

extension FiltersViewController: UITableViewDelegate, UITableViewDataSource, SwitchCellDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch TableSection(rawValue: section)! {
        case TableSection.deals:
            return 1
        case TableSection.distance:
            return distanceOn ? distances.count + 1 : 1
        case TableSection.sort:
            return sortOn ? sorts.count + 1 : 1
        default:
            return categories.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerText: String
        switch TableSection(rawValue: section)! {
        case TableSection.deals:
            headerText = "Deals"
        case TableSection.distance:
            headerText = "Distance"
        case TableSection.sort:
            headerText = "Sort By"
        default:
            headerText = "Category"
        }
        return headerText
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TableSection(rawValue: indexPath.section)! {
        case TableSection.deals:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
            cell.categoryLabel.text = "Offering a Deal"
            cell.switchButton.isOn = BusinessFilterSettings.sharedInstance.deals ?? false
            cell.delegate = self
            return cell
        case TableSection.distance:
            if (indexPath as NSIndexPath).row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SwitchCell
                cell.categoryLabel.text = "Filter by Distance"
                cell.switchButton.isOn = distanceOn
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "selectCell", for: indexPath) as! SelectCell
                let distance = distances[(indexPath as NSIndexPath).row - 1]
                cell.selectLabel.text = distance["name"] as! String?
                if ( distance["meters"] as! Double != selectedDistance ) {
                    cell.accessoryType = .none
                } else {
                    cell.accessoryType = .checkmark
                }
                return cell
            }
        case TableSection.sort:
            if (indexPath as NSIndexPath).row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SwitchCell
                cell.categoryLabel.text = "Custom Sort By?"
                cell.switchButton.isOn = sortOn
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "selectCell", for: indexPath) as! SelectCell
                let sort = sorts[(indexPath as NSIndexPath).row - 1]
                cell.selectLabel.text = sort["name"] as! String?
                if ( sort["sort"] as! YelpSortMode != selectedSort ) {
                    cell.accessoryType = .none
                } else {
                    cell.accessoryType = .checkmark
                }
                return cell
            }
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! SwitchCell
            cell.categoryLabel.text = categories[indexPath.row]["name"]
            if BusinessFilterSettings.sharedInstance.categories.contains(categories[indexPath.row]["code"]!) {
                cell.switchButton.isOn = true
            } else {
                cell.switchButton.isOn = categoryStates[indexPath.row] ?? false
            }
            
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = self.tableView(tableView, cellForRowAt: indexPath)
        if "selectCell" == cell.reuseIdentifier {

            switch TableSection(rawValue: indexPath.section)! {
            case TableSection.distance:
                
                if (indexPath as NSIndexPath).row != 0 {
                    selectedDistance = distances[(indexPath as NSIndexPath).row - 1]["meters"] as! Double
                    tableView.reloadSections(IndexSet(integer: 1), with: .none)
                }
                tableView.reloadSections(NSIndexSet(index: TableSection.distance.rawValue) as IndexSet, with: .none)
            case TableSection.sort:
                if (indexPath as NSIndexPath).row != 0 {
                    selectedSort = sorts[(indexPath as NSIndexPath).row - 1]["sort"] as! YelpSortMode
                    tableView.reloadSections(IndexSet(integer: 1), with: .none)
                }
                tableView.reloadSections(NSIndexSet(index: TableSection.sort.rawValue) as IndexSet, with: .none)
            default:
                break
            }
        }
    }

    func switchCell(switchCell: SwitchCell, didChangedValue value: Bool) {
        let ip = tableView.indexPath(for: switchCell)
        
        switch TableSection(rawValue: ip!.section)! {
        case TableSection.deals:
            selectedDeals = value
        case TableSection.distance:
            distanceOn = switchCell.switchButton.isOn
            if selectedDistance == maxDistance {
                selectedDistance = distances[0]["meters"] as! Double
            }
            tableView.reloadSections(NSIndexSet(index: TableSection.distance.rawValue) as IndexSet, with: .none)
        case TableSection.sort:
            sortOn = switchCell.switchButton.isOn
            if selectedSort == YelpSortMode.bestMatched {
                selectedSort = sorts[0]["sort"] as! YelpSortMode
            }
            tableView.reloadSections(NSIndexSet(index: TableSection.sort.rawValue) as IndexSet, with: .none)
        default:
            categoryStates[ip!.row] = value
        }
        
    }
}

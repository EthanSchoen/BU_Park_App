//
//  Main_Table.swift
//  BU Park
//
//  Created by Ethan Schoen on 11/5/16.
//  Copyright © 2016 <$1million products. All rights reserved.
//
import Foundation
import UIKit

class Lot_Table: UITableViewController {
    
    var lots : [lot] = []
    var serviceGroup = DispatchGroup()
    
    struct lot {
        var name: String
        var spots_open: Int
        var max_spots: Int
    }
    
    func getLots(urlString: String, completion: @escaping ((Bool) -> Void)) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error ?? "error was empty")
            } else {
                do {
                    let parsedData = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [[String : Any]]
                    for i in parsedData {
                        let obj = lot(name: i["name"] as! String, spots_open: i["open"] as! Int, max_spots: i["max"] as! Int)
                        self.lots.append(obj)
                    }
                    completion(true)
                } catch let error as NSError {
                    print(error)
                }
            }
            }.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLots(urlString: "http://localhost:3000/lots/", completion: {
            success in
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lots.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lot", for: indexPath) as! Lot_Table_Cell
        
        // Configure the cell...
        let alph = 0.6 * Float(lots[indexPath.row].spots_open)/Float(lots[indexPath.row].max_spots) + 0.1
        cell.lot_name.text = lots[indexPath.row].name
        cell.spots_open.text = String(lots[indexPath.row].spots_open) + " of " + String(lots[indexPath.row].max_spots)
        cell.backgroundColor = UIColor.init(red: 25/255.0, green: 146/255.0, blue: 54/255.0, alpha: CGFloat(alph))
        return cell
    }
}

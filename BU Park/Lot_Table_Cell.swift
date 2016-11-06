//
//  Lot_Table_CellTableViewCell.swift
//  BU Park
//
//  Created by Ethan Schoen on 11/5/16.
//  Copyright © 2016 <$1million products. All rights reserved.
//
import Foundation
import UIKit
import MapKit

class Lot_Table_Cell: UITableViewCell {
    
    @IBOutlet weak var lot_name: UILabel!
    @IBOutlet weak var spots_open: UILabel!
    var lat: CLLocationDegrees? = nil
    var long: CLLocationDegrees? = nil

    func getLocation() {
        let dest = MKPlacemark.init(coordinate: CLLocationCoordinate2DMake(lat!, long!))
        MKMapItem.openMaps(with: [MKMapItem.init(placemark: dest)], launchOptions: [MKLaunchOptionsDirectionsModeDefault : MKLaunchOptionsDirectionsModeKey])
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        //super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        if selected && lat != nil && long != nil {
            getLocation()
        }
    }

}

//
//  InterfaceController.swift
//  VenueWatch WatchKit Extension
//
//  Created by Jorge Costa on 03/06/15.
//  Copyright (c) 2015 Tuts+. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var locationLabel: WKInterfaceLabel!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        WKInterfaceController.openParentApplication(["request": "getFoursquareInfo"],
            reply: { (replyInfo, error) -> Void in
                if replyInfo != nil {
                    if let dataVal = replyInfo["Data"] as? NSData{
                        var err: NSError?
                        var jsonResult: NSDictionary = (NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary)!
                        println("Foursquare reply: \(jsonResult)")
                        
                        
                        var name:String = "", city:String = "", country:String = ""
                        if let response:NSDictionary = jsonResult["response"] as? NSDictionary{
                            if let venue:NSDictionary = response["venue"] as? NSDictionary{
                                //get name
                                name = venue["name"] as! String
                                
                                //get location
                                if let location:NSDictionary = venue["location"] as? NSDictionary{
                                    city = location["city"] as! String
                                    country = location["country"] as! String
                                }
                                
                                //concat location
                                let fullLocation = city + "," + country
                                
                                //present on labels
                                self.nameLabel.setText(name)
                                self.locationLabel.setText(fullLocation)
                                
                            }
                        }
                        
                    }
                }
                
        })
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

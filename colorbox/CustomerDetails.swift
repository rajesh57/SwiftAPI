//
//  CustomerDetails.swift
//  colorbox
//
//  Created by Rajesh on 25/01/17.
//  Copyright © 2017 That Thing in Swift. All rights reserved.
//

import Foundation
import UIKit

struct CustomerDetails {
    var MobileNumber : String? = nil
    var CardNumber : String? = nil
    var CustomerName : String? = nil
    var CustomerNumer :String? = nil
    var DefaultAmount :String? = nil
    init?(json: Dictionary <String, AnyObject>) {
        
        if let mobileNo = json[""] as? String {
            self.MobileNumber = mobileNo
        } else {
            self.MobileNumber = ""
        }
        if let cardNo = json[""] as? String {
            self.CardNumber = cardNo
        } else {
            self.CardNumber = ""
        }
        if let customerName = json[""] as? String {
            self.CustomerName = customerName
        } else {
            self.CustomerName = ""
        }
        if let customerNo = json[""] as? String {
            self.CustomerNumer = customerNo  }
        else {
            self.CustomerNumer = ""
        }
        if let defaulttAmt = json[""] as? String {
            self.DefaultAmount = defaulttAmt
        }else {
            self.DefaultAmount = ""
        }
    }

}

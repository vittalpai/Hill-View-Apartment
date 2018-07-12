//
//  MenuItems.swift
//  HillView-Apartment
//
//  Created by Vittal Pai on 7/10/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import Foundation
import UIKit


internal class MenuItems:NSObject  {
    
    static var menu = [Menu]()



    class func addMenuItems() -> Void {
        addItem("Pay Bills", "Pay your bills with one click", "pay-bills.png")
        addItem("Live Feeds", "Live feeds of your vehicle", "live.png")
        addItem("Chat", "Chat with Soceity ", "chat.png")
        addItem("Help", "Inform Corporation asdfadsfdsa", "help.jpeg")
    }
    
    class func addItem(_ name:String,_ team:String,_ image: String) -> Void {
        MenuItems.menu.append(Menu(
            name: name,
            team: team,
            image: image
        ))
    }
        
}


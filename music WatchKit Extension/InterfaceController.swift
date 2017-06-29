//
//  InterfaceController.swift
//  music WatchKit Extension
//
//  Created by ozcan akkoca on 5.05.2015.
//  Copyright (c) 2015 ozcan akkoca. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    var currentSelectedSound = 1

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func press() {
        currentSelectedSound = 1
        sendMessageToiPHone()
        
    }
    
    @IBAction func press2() {
        currentSelectedSound = 2
        sendMessageToiPHone()
    }
    
    @IBAction func press3() {
        currentSelectedSound = 3
        sendMessageToiPHone()
    }
    
    @IBAction func press4() {
        currentSelectedSound = 4
        sendMessageToiPHone()
    }
    @IBAction func stop() {
        currentSelectedSound = 5
        sendMessageToiPHone()
    }
    
    
    func sendMessageToiPHone() {
        let message = ["audio": String(currentSelectedSound)]
        WKInterfaceController.openParentApplication(message, reply: nil)
    }

}

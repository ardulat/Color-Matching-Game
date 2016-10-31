//
//  secondViweController.swift
//  Сәйкес пе?
//
//  Created by MacBOOK PRO on 10.06.16.
//  Copyright © 2016 Nazarbayev University. All rights reserved.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    
    
    @IBOutlet weak var resultLabel: UILabel!
    
    var recievedResult: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultLabel.text = recievedResult
    }
    
    @IBAction func backButtonTouched() {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
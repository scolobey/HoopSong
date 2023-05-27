//
//  ViewController.swift
//  HoopSong
//
//  Created by Ryan on 5/27/23.
//

import UIKit

class ShotViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var shotTitleField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        shotTitleField.delegate = self
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let shotName = textField.text {
            print("theres text")
        }
        
        return true
    }
}


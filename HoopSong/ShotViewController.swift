//
//  ViewController.swift
//  HoopSong
//
//  Created by Ryan on 5/27/23.
//

import UIKit
import CoreData

class ShotViewController: UIViewController, UITextFieldDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var shotTitleField: UITextField!
    @IBOutlet var submitButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        shotTitleField.becomeFirstResponder()
        shotTitleField.delegate = self
        setupSubmitButton()
    }
    
    func setupSubmitButton() {
        submitButton.addTarget(self, action: #selector(self.submitAction(_:)), for: .touchUpInside)
    }
    
    @objc func submitAction(_ sender:UIButton!) {
        if let shotName = shotTitleField.text {
            createShot(shotName: shotName)
        }
        
        //dismiss everything and return
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let shotName = textField.text {
            createShot(shotName: shotName)
        }
        
        //dismiss everything and return
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
        
        return true
    }
    
    func createShot(shotName: String) {
        let newShot = HoopsShot(context: context)
        newShot.name = shotName
        
        do {
            try context.save()
        }
        catch {
            let alert = UIAlertController(title: "Noooo!", message: "There was an error savinging your shot. Email minedied@gmail.com for help.", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true)
        }
    }
    
}

//
//  SessionViewController.swift
//  HoopSong
//
//  Created by Ryan on 5/27/23.
//

import UIKit

class SessionViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var makesPicker: UIPickerView!
    @IBOutlet var attemptsPicker: UIPickerView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var shotTableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shotTableview.dequeueReusableCell(withIdentifier: "sessionTableviewCell", for: indexPath)
        cell.backgroundColor = UIColor.white
        return cell
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        10
    }
}

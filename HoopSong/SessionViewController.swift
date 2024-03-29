//
//  SessionViewController.swift
//  HoopSong
//
//  Created by Ryan on 5/27/23.
//

import UIKit

class SessionViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let editTitleSegueIdentifier = "EditTitleSegue"

    var shot = HoopsShot()
    var sessionMakes = 5
    var sessionAttempts = 10
    
    @IBOutlet var makesPicker: UIPickerView!
    @IBOutlet var attemptsPicker: UIPickerView!
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var shotTableview: UITableView!
    
//    let editSessionTitle = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = shot.name
        
        prepareTableView()
        preparePickerViews()
        setupSubmitButton()
        
        shotTableview.reloadData()
    }
    
    func preparePickerViews() {
        self.makesPicker.delegate = self
        self.makesPicker.dataSource = self
        
        self.attemptsPicker.delegate = self
        self.attemptsPicker.dataSource = self
        
        makesPicker.selectRow(5, inComponent: 0, animated: true)
        attemptsPicker.selectRow(10, inComponent: 0, animated: true)
    }
    
    func prepareTableView() {
        self.shotTableview.delegate = self
        self.shotTableview.dataSource = self
    }
    
    func setupSubmitButton() {
        submitButton.addTarget(self, action: #selector(self.submitAction(_:)), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shot.sessions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shotTableview.dequeueReusableCell(withIdentifier: "sessionTableviewCell", for: indexPath)
       
        let session = shot.sessionArray[indexPath.row]
        
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "MM/dd - HH:MM"
        
        cell.detailTextLabel?.text = "\(session.makes)/\(session.attempts)"
        cell.textLabel?.text = "\(myFormatter.string(from: session.createdAt!))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            //remove from data source
            deleteSession(session: shot.sessionArray[indexPath.row])
            
            shotTableview.reloadData()
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 20
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return row.description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            sessionMakes = row
        } else {
            sessionAttempts = row
        }
   }
    
    @objc func submitAction(_ sender:UIButton!) {
        createSession(makes: Int16(sessionMakes), attempts: Int16(sessionAttempts))
    }
    
    func createSession(makes: Int16, attempts: Int16) {
        let newSession = HoopsSession(context: context)

        newSession.makes = makes
        newSession.attempts = attempts
        newSession.createdAt = Date()
        
        shot.addToSessions(newSession)
        
        do {
            try context.save()
        }
        catch {
            let alert = UIAlertController(title: "Oops!", message: "There was an error logging your session. Email minedied@gmail.com for help.", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true)
        }
        
        shotTableview.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
    }
    
    func deleteSession(session: HoopsSession) {
        shot.removeFromSessions(session)
        
        do {
            try context.save()
        }
        catch {
            let alert = UIAlertController(title: "Oops!", message: "There was an error deleting your session. Email minedied@gmail.com for help.", preferredStyle: .actionSheet)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == editTitleSegueIdentifier,
            let destination = segue.destination as? ShotViewController
        {
            destination.editBool = true
            destination.shot = shot
        }
    }
    
}

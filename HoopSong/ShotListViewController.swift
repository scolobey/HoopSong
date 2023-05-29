//
//  ShotViewController.swift
//  HoopSong
//
//  Created by Ryan on 5/27/23.
//

import Foundation
import UIKit
import CoreData

class ShotListViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var shots: [HoopsShot] = []
    
    @IBOutlet var shotTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetch()
        shotTableview.reloadData()
    }
    
    func setupTableView() {
        shotTableview.delegate = self
        shotTableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shots.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shotTableview.dequeueReusableCell(withIdentifier: "shotTableviewCell", for: indexPath)
        cell.backgroundColor = UIColor.white
        
        let shot = shots[indexPath.row]
        cell.textLabel?.text = shot.name
        
        return cell
    }

    func fetch() {
        let request = NSFetchRequest<HoopsShot>(entityName: "HoopsShot")
        
        do {
            shots = try context.fetch(request)
        }
        catch {
            print("error fetching shots")
        }
    }
}

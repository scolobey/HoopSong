//
//  ShotViewController.swift
//  HoopSong
//
//  Created by Ryan on 5/27/23.
//

import Foundation
import UIKit

class ShotListViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    @IBOutlet var shotTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        shotTableview.delegate = self
        shotTableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shotTableview.dequeueReusableCell(withIdentifier: "shotTableviewCell", for: indexPath)
        cell.backgroundColor = UIColor.white
        return cell
    }

}

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
    let sessionSegueIdentifier = "ShowSessionsSegue"
    
    var shots: [HoopsShot] = []
    
    @IBOutlet var shotTableview: UITableView!
    
    @IBOutlet var dailyPercentage: UILabel!
    @IBOutlet var totalPercentage: UILabel!
    @IBOutlet var dailyShots: UILabel!
    @IBOutlet var totalShots: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetch()
        shotTableview.reloadData()
        setupStatsLabels()
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
        let sessionList = shot.sessionArray
        
        let totalMakes = sessionList.map { $0.makes }.reduce(0, +)
        let totalAttempts = sessionList.map { $0.attempts }.reduce(0, +)
        var shotPercentage = Int16(0)
        
        if (totalAttempts > 0) {
            shotPercentage = (100 * totalMakes)/totalAttempts
        }
        
        cell.detailTextLabel?.text = "\(totalMakes)/\(totalAttempts) - \(shotPercentage)%"
        cell.textLabel?.text = shot.name
        
        return cell
    }
    
    private func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    private func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCell.EditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            print("time to remove \(indexPath.row)")
        }
    }
    
    func flattenMakes(sessionList: [HoopsSession]) -> Int16 {
        return sessionList.map {
            $0.makes
        }.reduce(0, +)
    }
    
    func flattenAttempts(sessionList: [HoopsSession]) -> Int16 {
        return sessionList.map {
            $0.attempts
        }.reduce(0, +)
    }
    
    func flattenTodaysMakes(sessionList: [HoopsSession]) -> Int16 {
        let cal = Calendar.current
        
        return sessionList.filter {
            cal.isDateInToday($0.createdAt!)
        }.map {
            $0.makes
        }.reduce(0, +)
    }
    
    func flattenTodaysAttempts(sessionList: [HoopsSession]) -> Int16 {
        let cal = Calendar.current
        
        return sessionList.filter {
            cal.isDateInToday($0.createdAt!)
        }.map {
            $0.attempts
        }.reduce(0, +)
    }
    
    func setupStatsLabels() {
        
        let totalMakes = shots.map{
            flattenMakes(sessionList: $0.sessionArray)
        }.reduce(0, +)
        
        let totalAttempts = shots.map{
            flattenAttempts(sessionList: $0.sessionArray)
        }.reduce(0, +)
        
        let todaysMakes = shots.map{
            flattenTodaysMakes(sessionList: $0.sessionArray)
        }.reduce(0, +)
        
        let todaysAttempts = shots.map{
            flattenTodaysAttempts(sessionList: $0.sessionArray)
        }.reduce(0, +)
        
        var dayPercent = Int16(0)
        var cumulativePercent = Int16(0)
        
        if (totalAttempts > 0) {
            cumulativePercent = (100 * totalMakes)/totalAttempts
        }
        
        if (todaysAttempts > 0) {
            dayPercent = (100 * todaysMakes)/todaysAttempts
        }
        
        dailyPercentage.text = "\(dayPercent)%"
        totalPercentage.text = "\(cumulativePercent)%"
        dailyShots.text = "\(todaysAttempts) shots"
        totalShots.text = "\(totalAttempts) shots"
    }

    func fetch() {
        print("fetching shots.")
        let request = NSFetchRequest<HoopsShot>(entityName: "HoopsShot")
        
        do {
            shots = try context.fetch(request)
        }
        catch {
            print("error fetching shots")
        }
        
        print("found \(shots.count) shots")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == sessionSegueIdentifier,
            let destination = segue.destination as? SessionViewController,
            let shotIndex = shotTableview.indexPathForSelectedRow?.row
        {
            destination.shot = shots[shotIndex]
        }
    }
}

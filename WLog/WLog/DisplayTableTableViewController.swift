//
//  DisplayTableTableViewController.swift
//  WLog
//
//  Created by Izloop on 3/19/19.
//  Copyright © 2019 Peter Levi Hornig. All rights reserved.
//

import UIKit

class DisplayTableTableViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items: [Item] = []
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 69
        self.tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    func fetchData() {
        
        do {
            items = try context.fetch(Item.fetchRequest())
            print(items)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Couldn't Fetch Data")
        }
        
    }

}

extension DisplayTableTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.text = items[indexPath.row].entry
        cell.textLabel?.text = items.reversed()[indexPath.row].entry
        cell.textLabel?.textColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
        
        let date = items.reversed()[indexPath.row].date
        let time = items.reversed()[indexPath.row].time
        
        if let date = date, let time = time {
            let timeStamp = "Added on \(date) at \(time)"
            cell.detailTextLabel?.text = timeStamp
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            
            let item = self.items[indexPath.row]
            self.context.delete(item)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            self.items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        let share = UITableViewRowAction(style: .default, title: "Share") { (acttion, indexPath ) in }
        
        delete.backgroundColor = UIColor.black
        
        return [delete, share]
    }
}

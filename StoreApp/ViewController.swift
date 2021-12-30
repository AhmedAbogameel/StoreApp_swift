//
//  ViewController.swift
//  StoreApp
//
//  Created by Jemi on 25/11/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var nsController:NSFetchedResultsController<Items>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadItems()
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = nsController.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
}

extension ViewController : NSFetchedResultsControllerDelegate {
    
    func loadItems() {
        let fetchRequest:NSFetchRequest<Items> = Items.fetchRequest()
        let sorting = NSSortDescriptor(key: "date_add", ascending: true)
        fetchRequest.sortDescriptors = [sorting]
        nsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        nsController.delegate = self
        do {
            try nsController.performFetch()
        } catch {
            print("Error Fetching Items!")
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func configureCell(cell:TableViewCell,indexPath:IndexPath)     {
            let Singleitem = nsController.object(at: indexPath)
            cell.initData(item:Singleitem)
        }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch(type) {
                    
                case.insert:
                    if let indexPath = newIndexPath {
                        tableView.insertRows(at: [indexPath], with: .fade)
                    }
                    break
                case.delete:
                    if let indexPath = indexPath {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                    break
                case.update:
                    if let indexPath = indexPath {
                        let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
//                        tableView.reloadRows(at: [indexPath], with: .fade)
                        configureCell(cell: cell, indexPath: indexPath )
                    }
                    break
                case.move:
                    if let indexPath = indexPath {
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                    if let indexPath = newIndexPath {
                        tableView.insertRows(at: [indexPath], with: .fade)
                    }
                    break
        default:
            print("ERROR")
                    
                }
        
    }
    
}

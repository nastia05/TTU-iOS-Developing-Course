//
//  NotesTVC.swift
//  TTUNotes
//
//  Created by Anastasiia Soboleva on 08.03.17.
//  Copyright © 2017 Anastasiia Soboleva. All rights reserved.
//

import UIKit
import CoreData

class ProjectsTVC: UITableViewController {

    lazy var projectsResultsController: NSFetchedResultsController<Project> = {
        let request: NSFetchRequest<Project> = Project.fetchRequest()
        let sortDescr = NSSortDescriptor(key: "creationDate", ascending: false)
        request.sortDescriptors = [sortDescr]
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.container.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try projectsResultsController.performFetch()
        } catch let error {
            print(error)
        }
    }
    
    @IBAction func backToProjects(_ sender: UIStoryboardSegue) {
        
    }
    
}

let dateFormatter = DateFormatter.common()

//MARK: - fetched results controller delegate
extension ProjectsTVC: NSFetchedResultsControllerDelegate {
	
	
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
}

//MARK: - table view delegate / data source
extension ProjectsTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let objs = projectsResultsController.fetchedObjects else {
            fatalError("performFetch() wasn't called")
        }
        return objs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCellSID") else {
            fatalError("No cell")
        }
        guard let object = projectsResultsController.fetchedObjects?[indexPath.row] else {
            fatalError("No object for index \(indexPath.row)")
        }
        
        cell.textLabel?.text = object.name
        cell.detailTextLabel?.text = dateFormatter.string(from: object.creationDate as! Date)
        return cell
    }
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectSectionCellSID") else {
			fatalError("No cell")
		}
	}
}

extension DateFormatter {
    static func common() -> DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .long
		df.timeStyle = .medium
        return df
    }
}


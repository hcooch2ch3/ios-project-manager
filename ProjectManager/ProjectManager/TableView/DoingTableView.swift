//
//  DoingTableView.swift
//  ProjectManager
//
//  Created by 임성민 on 2021/03/17.
//

import UIKit
import CoreData

final class DoingTableView: ThingTableView {
    
    private lazy var fetchedResultsController: NSFetchedResultsController<Thing> = {
        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Thing> = NSFetchRequest<Thing>(entityName: "Thing")
        fetchRequest.predicate = NSPredicate(format: "state = 'doing'")
        let sort = NSSortDescriptor(key: #keyPath(Thing.dateNumber), ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override init() {
        super.init()
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.doingTitle)
        fetch()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        tableHeaderView = ThingTableHeaderView(height: 50, title: Strings.doingTitle)
        fetch()
    }
    
    private func fetch() {
        do {
            try fetchedResultsController.performFetch()
        } catch {
            
        }
        if let fetchedObjects = fetchedResultsController.fetchedObjects {
            self.list = fetchedObjects
            self.reloadData()
        }
    }
}

extension DoingTableView: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete, .insert, .update:
            self.reloadData()
        default:
            break
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.reloadData()
    }
}

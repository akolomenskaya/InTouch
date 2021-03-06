//
//  File.swift
//  InTouchApp
//
//  Created by Михаил Борисов on 14/04/2019.
//  Copyright © 2019 Mikhail Borisov. All rights reserved.
//

import Foundation
import CoreData
class ListProvider: NSObject, UITableViewDataSource {
    lazy var fetchedResultsController: NSFetchedResultsController<User> = {
        guard let request: NSFetchRequest<User> = User.fetchRequestAnotherUsers() else { fatalError() }
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        let frc =  NSFetchedResultsController(fetchRequest: request, managedObjectContext: StorageManager.Instance.coreDataStack.mainContext, sectionNameKeyPath: nil, cacheName: nil)
        return frc
    }()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = fetchedResultsController.sections else { return 0 }
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = fetchedResultsController.sections else { return nil }
            switch sections[section].indexTitle {
            case "0" :
                return "Offline"
            default:
                return "Online"
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { fatalError() }
        let user = self.fetchedResultsController.object(at: indexPath)
        if let image = user.image {
            cell.profileImage.image = UIImage(data: image)
            cell.profileImage.layer.cornerRadius = 22.5
        }
          guard let userID = user.userID else { fatalError("No found UserID. Are you Okay?") }
        let lastMessage = Conversation.requestLastMessageInConversation(in: StorageManager.Instance.coreDataStack.mainContext, conversationID: userID)
        let message = lastMessage?.message ?? ""
        let online = user.isOnline
        let date = lastMessage?.date ?? Date()
        let name = user.name ?? ""
        cell.configureCell(name: name, message: message, date: date, online: online, hasUnreadmessage: true)
        // swiftlint:enable force_cast
        return cell
    }
    
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                let managedObject = fetchedResultsController.object(at: indexPath)
                StorageManager.Instance.coreDataStack.mainContext.delete(managedObject)
                do {  StorageManager.Instance.coreDataStack.performSave()
                    let request2: NSFetchRequest<User> = User.fetchRequest()
                    do {
                        let result2 = try StorageManager.Instance.coreDataStack.mainContext.fetch(request2)
                        print(result2.count)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchedResultsController.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        print(sectionInfo.numberOfObjects)
        return sectionInfo.numberOfObjects
    }
}

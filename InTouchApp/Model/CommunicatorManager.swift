//
//  File.swift
//  InTouchApp
//
//  Created by Михаил Борисов on 19/03/2019.
//  Copyright © 2019 Mikhail Borisov. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity
import CoreData
struct MessageStruct {
    let inOut: Int
    let message: String
    let date: Date
}
class CommunicatorManager: NSObject, CommunicatorDelegate {
    var users: [(username: String, peerID: String)] = []
    weak var delegate: dataDelegate?
    func didFoundUser(userID: String, userName: String?) {
       
    }
    
    func didLostUser(userID: String) {
        let user = AppUser.fetchCurrectUserWithID(in: StorageManager.Instance.coreDataStack.mainContext, userId: userID)
        user?.isOnline = false
        StorageManager.Instance.coreDataStack.saveContext.performAndWait {
            StorageManager.Instance.coreDataStack.performSave()
        }
        
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        print(error.localizedDescription)
    }
    
    func failedToStartAdvertising(error: Error) {
        print(error.localizedDescription)
    }
    
    func didRecieveMessage(text: String, fromUser: String, toUser: String) {
        delegate?.reloadData(status: true)
    }
    var communicator: MultipeerCommunicator
    static var Instance = CommunicatorManager()
    private override init() {
        self.communicator = MultipeerCommunicator()
        super.init()
        self.communicator.delegate = self
    }
    
}
protocol dataDelegate: class {
    func reloadData(status: Bool)
}

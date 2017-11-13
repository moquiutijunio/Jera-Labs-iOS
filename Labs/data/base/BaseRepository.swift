//
//  BaseRepository.swift
//  Labs
//
//  Created by Junio Moquiuti on 30/10/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

protocol BaseRepositoryProtocol: class {
    
}

class BaseRepository: BaseRepositoryProtocol {
    
    let firebaseRealtimeDatabase: FirebaseRealtimeDatabase

    init(firebaseRealtimeDatabase: FirebaseRealtimeDatabase) {
        self.firebaseRealtimeDatabase = firebaseRealtimeDatabase
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

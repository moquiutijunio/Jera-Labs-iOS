//
//  LabsRepository.swift
//  Labs
//
//  Created by Junio Moquiuti on 30/10/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol LabsRepositoryProtocol: class {
    var labsResponse: Observable<RequestResponse<[LabAPI]?>> {get}
    func getAllLabsInDB()
}

class LabsRepository: BaseRepository, LabsRepositoryProtocol {
    
    var labsResponse: Observable<RequestResponse<[LabAPI]?>> {
        return firebaseRealtimeDatabase.labsResponseVariable.asObservable()
    }
    
    func getAllLabsInDB() {
        firebaseRealtimeDatabase.getAllLabsInDB()
    }
}

//
//  LabsDescriptionRepository.swift
//  Labs
//
//  Created by Junio Moquiuti on 30/10/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol LabsDescriptionRepositoryProtocol: class {
    var labsResponse: Observable<RequestResponse<[LabAPI]?>> {get}
    func getAllLabsInDB()
}

class LabsDescriptionRepository: BaseRepository, LabsDescriptionRepositoryProtocol {
    
    var labsResponse: Observable<RequestResponse<[LabAPI]?>> {
        return firebaseRealtimeDatabase.labsResponseVariable.asObservable()
    }
    
    func getAllLabsInDB() {
        firebaseRealtimeDatabase.getAllLabsInDB()
    }
}

//
//  FirebaseRealtimeDatabase.swift
//  Labs
//
//  Created by Junio Moquiuti on 31/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift
import Result
import FirebaseDatabase

protocol FirebaseRealtimeDatabaseProtocol {
    var labsResponse: Observable<RequestResponse<[LabAPI]?>> {get}
    func getAllLabsInDB()
}

class FirebaseRealtimeDatabase: FirebaseRealtimeDatabaseProtocol {
    
    var ref: DatabaseReference!
    var labsVariable = Variable<RequestResponse<[LabAPI]?>>(.new)
    
    var labsResponse: Observable<RequestResponse<[LabAPI]?>> {
        return labsVariable.asObservable()
    }
    
    func getAllLabsInDB() {
        ref = Database.database().reference()
        labsVariable.value = .loading
        
        ref.queryOrdered(byChild: "projects").observe(.childAdded, with: { [weak self] (snapshot) in
            guard let strongSelf = self else {return}
            guard let values = snapshot.value as? [Any] else {return}
            var labsAPI = [LabAPI]()
            
            for value in values {
                guard let valueJson = value as? [String: Any] else {return}
                guard let labAPI = LabAPI(JSON: valueJson) else {return}
                
                labsAPI.append(labAPI)
            }
            
            strongSelf.labsVariable.value = .success(responseObject: labsAPI)
        }) { [weak self] (error) in
            guard let strongSelf = self else {return}
            strongSelf.labsVariable.value = .failure(error: error.localizedDescription)
        }
    }
}

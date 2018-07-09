//
//  AboutRepository.swift
//  Labs
//
//  Created by Junio Moquiuti on 20/11/2017.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol AboutRepositoryProtocol: class {
    var aboutResponse: Observable<RequestResponse<AboutAPI?>> { get }
    func getAboutInformationInDB()
}

class AboutRepository: BaseRepository, AboutRepositoryProtocol {
    
    var aboutResponse: Observable<RequestResponse<AboutAPI?>> {
        return firebaseRealtimeDatabase.aboutResponseVariable.asObservable()
    }
    
    func getAboutInformationInDB() {
        firebaseRealtimeDatabase.getAboutInformationInDB()
    }
}

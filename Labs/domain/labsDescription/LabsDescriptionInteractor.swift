//
//  LabsDescriptionInteractor.swift
//  Labs
//
//  Created by Junio Moquiuti on 23/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit
import RxSwift

protocol LabsDescriptionInteractorProtocol {
    var labsDescriptinResponse: Observable<RequestResponse<[Lab]>> { get }
    func makeRequestLabs()
}

class LabsDescriptionInteractor: BaseInteractor {
    
    let labsDescriptinResponseVariable = Variable<RequestResponse<[Lab]>>(.new)
    
}

extension LabsDescriptionInteractor: LabsDescriptionInteractorProtocol {
    
    var labsDescriptinResponse: Observable<RequestResponse<[Lab]>> {
        return labsDescriptinResponseVariable.asObservable()
    }
    
    func makeRequestLabs() {
        //        disposeBag = DisposeBag()
        //
        //        labsDescriptinResponseVariable.value = .loading
        
        var labs = [Lab]()
        for index in 1...10 {
            
            if index % 2 == 0 {
                
                let avatar = URL(string: "https://avatars2.githubusercontent.com/u/1772207?v=3&s=400")
                
                let lab = Lab(id: index,
                              name: "Naka bebe \(index)",
                    avatar: avatar!,
                    description: "Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste ",
                    background: avatar!,
                    team: nil,
                    appleStore: nil,
                    playStore: nil,
                    github: nil,
                    gitlab: nil)
                
                labs.append(lab)
                
            } else {
                
                let avatar = URL(string: "https://media.licdn.com/mpr/mpr/shrinknp_200_200/AAEAAQAAAAAAAA2uAAAAJGI5ZjRhZjdmLWRjMGYtNDUwZC05YWIzLWJjOGE5OGIzYzNjOA.jpg")
                
                let lab = Lab(id: index,
                    name: "Parça Bolado \(index)",
                    avatar: avatar!,
                    description: "Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste Teste ",
                    background: avatar!,
                    team: nil,
                    appleStore: nil,
                    playStore: nil,
                    github: nil,
                    gitlab: nil)
                
                labs.append(lab)
            }
            
        }
        
        labsDescriptinResponseVariable.value = .success(responseObject: labs)
        
    }
}

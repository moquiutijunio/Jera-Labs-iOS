//
//  Lab.swift
//  Labs
//
//  Created by Junio Moquiuti on 26/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

struct Lab {
    
    var id: Int
    var name: String
    var avatar: URL
    var description: String
    var background: URL
    var team: [URL]?
    var appleStore: URL?
    var playStore: URL?
    var github: URL?
    var gitlab: URL?
}

extension Lab {
    
    static func map(labAPI: LabAPI) -> Lab? {
        if let id = labAPI.id,
            let name = labAPI.name,
            let avatar = labAPI.avatar,
            let description = labAPI.description,
            let background = labAPI.background {
            
            return Lab(id: id,
                       name: name,
                       avatar: avatar,
                       description: description,
                       background: background,
                       team: labAPI.team,
                       appleStore: labAPI.appleStore,
                       playStore: labAPI.playStore,
                       github: labAPI.github,
                       gitlab: labAPI.gitlab)
        }
        
        return nil
    }
    
    static func mapArray(labsAPI: [LabAPI]) -> [Lab]? {
        return labsAPI
            .map { Lab.map(labAPI: $0) }
            .filter { $0 != nil }
            .map {$0!}
    }
}

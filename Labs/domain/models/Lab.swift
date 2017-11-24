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
    var avatar: URL?
    var description: String
    var background: URL?
    var team: Team?
    var appleStore: URL?
    var playStore: URL?
    var github: URL?
    var gitlab: URL?
}

extension Lab {
    
    static func map(labAPI: LabAPI) -> Lab? {
        if let id = labAPI.id,
            let name = labAPI.name,
            let description = labAPI.description {
            
            return Lab(id: id,
                       name: name,
                       avatar: labAPI.avatar,
                       description: description,
                       background: labAPI.background,
                       team: Team.map(teamAPI: labAPI.team),
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

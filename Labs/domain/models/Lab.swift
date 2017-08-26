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
            let avatarURL = labAPI.avatar?.convertToURL(),
            let description = labAPI.description,
            let backgroundURL = labAPI.background?.convertToURL() {
            
            var teamURL = [URL]()
            if let team = labAPI.team {
                teamURL = team
                    .map { $0.convertToURL() }
                    .filter { $0 != nil }
                    .map {$0!}
            }
            
            return Lab(id: id,
                       name: name,
                       avatar: avatarURL,
                       description: description,
                       background: backgroundURL,
                       team: teamURL,
                       appleStore: labAPI.appleStore?.convertToURL(),
                       playStore: labAPI.playStore?.convertToURL(),
                       github: labAPI.github?.convertToURL(),
                       gitlab: labAPI.gitlab?.convertToURL())
        }
        
        return nil
    }
    
    static func mapArray(labsAPI: [LabAPI]) -> [Lab] {
        return labsAPI
            .map { Lab.map(labAPI: $0) }
            .filter { $0 != nil }
            .map {$0!}
    }
}

//
//  LabAPI.swift
//  Labs
//
//  Created by Junio Moquiuti on 26/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import ObjectMapper

class LabAPI: Mappable {
    
    var id: Int?
    var name: String?
    var avatar: String?
    var description: String?
    var background: String?
    var team: [String]?
    var appleStore: String?
    var playStore: String?
    var github: String?
    var gitlab: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar <- map["avatar"]
        description <- map["description"]
        background <- map["background"]
        team <- map["team"]
        appleStore <- map["link.apple_store"]
        playStore <- map["link.play_store"]
        github <- map["link.github"]
        gitlab <- map["link.gitlab"]
    }
}

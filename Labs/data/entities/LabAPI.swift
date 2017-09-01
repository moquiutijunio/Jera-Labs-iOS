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
    var avatar: URL?
    var description: String?
    var background: URL?
    var team: [URL]?
    var appleStore: URL?
    var playStore: URL?
    var github: URL?
    var gitlab: URL?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar <- (map["avatar"], URLTransform())
        description <- map["description"]
        background <- (map["background"], URLTransform())
        team <- (map["team"], URLTransform())
        appleStore <- (map["link.apple_store"], URLTransform())
        playStore <- (map["link.play_store"], URLTransform())
        github <- (map["link.github"], URLTransform())
        gitlab <- (map["link.gitlab"], URLTransform())
    }
}

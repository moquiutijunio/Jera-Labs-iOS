//
//  AboutAPI.swift
//  Labs
//
//  Created by Junio Moquiuti on 20/11/2017.
//  Copyright © 2017 Jera. All rights reserved.
//

import ObjectMapper

class AboutAPI: Mappable {
    
    var version: String?
    var description: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        version <- map["version"]
        description <- map["description"]
    }
}

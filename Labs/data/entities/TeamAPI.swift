//
//  TeamAPI.swift
//  Labs
//
//  Created by Junio Moquiuti on 05/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import ObjectMapper

class TeamAPI: Mappable {
    var first: URL?
    var second: URL?
    var third: URL?
    var fourth: URL?
    var fifth: URL?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        first <- (map["first"], URLTransform())
        second <- (map["second"], URLTransform())
        third <- (map["third"], URLTransform())
        fourth <- (map["fourth"], URLTransform())
        fifth <- (map["fifth"], URLTransform())
    }
}

//
//  About.swift
//  Labs
//
//  Created by Junio Moquiuti on 20/11/2017.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

struct About {
    
    var version: String
    var description: String
}

extension About {
    
    static func map(aboutAPI: AboutAPI) -> About? {
        if let version = aboutAPI.version,
            let description = aboutAPI.description {
            
            return About(version: version,
                         description: description)
        }
        
        return nil
    }
}

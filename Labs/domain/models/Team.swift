//
//  Team.swift
//  Labs
//
//  Created by Junio Moquiuti on 05/09/17.
//  Copyright © 2017 Jera. All rights reserved.
//

import UIKit

struct Team {
    var first: URL?
    var second: URL?
    var third: URL?
    var fourth: URL?
    var fifth: URL?
}

extension Team {
    
    static func map(teamAPI: TeamAPI?) -> Team? {
        guard let teamAPI = teamAPI else {return nil}
        return Team(first: teamAPI.first, second: teamAPI.second, third: teamAPI.third, fourth: teamAPI.fourth, fifth: teamAPI.fifth)
    }
}

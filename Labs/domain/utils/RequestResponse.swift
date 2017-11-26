//
//  RequestResponse.swift
//  Labs
//
//  Created by Junio Moquiuti on 26/08/17.
//  Copyright © 2017 Jera. All rights reserved.
//

enum RequestResponse<T> {
    case new
    case loading
    case success(responseObject: T)
    case failure(error: String)
    case cancelled
    case noContent
}

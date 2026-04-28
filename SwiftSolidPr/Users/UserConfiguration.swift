//
//  UserConfiguration.swift
//  SwiftSolidPr
//
//  Created by apple on 08/03/26.
//

import Foundation

struct UserConfiguration:ConfigRequest{
    var path = "/users"
    var method = HTTPType.Get.rawValue
}

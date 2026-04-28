//
//  ConfigRequest.swift
//  SwiftSolidPr
//
//  Created by apple on 08/03/26.
//

import Foundation
import SwiftUI

Protocol ConfigRequest{
    var path:String {get}
    var method:HTTPType {get}
    var data:Data? {get}
    var header:[String:String]? {get}
    var queryString:[URLQueryItem]? {get}
}

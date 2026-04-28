//
//  ApiUtil.swift
//  SwiftSolidPr
//
//  Created by apple on 25/04/26.
//

import Foundation

enum HTTPMethod:String{
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum NetworkError:Error{
    case invalidResponse
    case invalidRequest
    case unauthorized
    case decodingFailed
    case serverError(String)
    case unknown(Error)
}

protocol APIEndpoint{
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems:[String: String]? {get}
    var body: Encodable? { get }
}

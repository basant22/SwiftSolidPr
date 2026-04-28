//
//  RequestConfiguration.swift
//  SwiftSolidPr
//
//  Created by apple on 08/03/26.
//

import Foundation

struct RequestConfiguration{
    func manageConfig(config:ConfigRequest)->URLRequest{
        guard let componenet = URLComponents(string: baseURL + config.path) else {return nil}
        if let query = config.queryString{
            componenet.queryItems= query
        }
        
        guard let url = componenet.url else {return nil}
        var urlReq = URLRequest(url: url)
        urlReq.httpBody = config.body
        urlReq.httpMethod = config.method.rawValue
        
        urlReq.setValue("application/json", forHTTPHeaderField: "content-type")
        config.headers.forEach{urlReq.setValue($0.value,forHTTPHeaderField:$0.key)}
    }
}


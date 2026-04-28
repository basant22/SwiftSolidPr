//
//  ApiCaller.swift
//  SwiftSolidPr
//
//  Created by apple on 25/04/26.
//

import Foundation

protocol ApiDispatcher{
    func networkCall<T:Decodable>(_ requset:URLRequest) async throws -> T
}

class NetworkCall:ApiDispatcher{
    func networkCall<T:Decodable>(_ requset:URLRequest) async throws -> T{
        
        let (data,response) = try await URLSession.shared.data(for: requset)
        guard let respo = response as? HTTPURLResponse else
        {
            throw NetworkError.invalidResponse
        }
        switch respo.statusCode{
        case 200...299:
            do{
                return try JSONDecoder().decode(T.self, from: data)
            }catch{
                throw NetworkError.decodingFailed
            }
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.serverError("Status code:\(respo.statusCode)")
        }
        
    }
}

struct URLRequestfactory{
    static func make(endPoint:APIEndpoint)->URLRequest{
        var url = endPoint.baseURL.appendingPathComponent(endPoint.path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        // 2. Handle Query Items (if any)
        // If your endpoint protocol supports [String: String] queries:
        if let queryItems = endPoint.queryItems {
            components?.queryItems = queryItems.map {
                URLQueryItem(
                    name: $0.key,
                    value: $0.value
                )
            }
            if let updatedURL = components?.url {
                url = updatedURL
            }
        }
        
        let request = URLRequest(url: url)
        return request
    }
}

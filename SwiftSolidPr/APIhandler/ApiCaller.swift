//
//  ApiCaller.swift
//  SwiftSolidPr
//
//  Created by apple on 25/04/26.
//

import Foundation

protocol ApiDispatcher{
    func networkCall<T:Decodable>(_ requset:URLRequest) async throws -> T
    func networkCallForFile(_ url:URL) async throws -> Data
    func fileDownloadAsync(request: URLRequest) async throws -> URL
}

class NetworkCall:ApiDispatcher{
    func networkCallForFile(_ url:URL) async throws -> Data{
        let (data, response) = try await URLSession.shared.data(from: url)
            
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw NSError(domain: "DownloadError", code: 0, userInfo: nil)
            }
        return data
    }
    func fileDownloadAsync(request: URLRequest) async throws -> URL {
            
            do {
                let (fileUrl, response) = try await URLSession.shared.download(for: request)
                
                guard let http = response as? HTTPURLResponse else {
                    throw NetworkError.invalidResponse
                }
                
                guard (200...299).contains(http.statusCode) else {
                    throw NetworkError.invalidResponse
                }
                
                print("tmp directory path => \(fileUrl)")
                
               return fileUrl
            }
            catch let error {
                print("HttpUtility.fileDownloadAsync => \(error)")
                throw NetworkError.invalidResponse
            }
        }
    func networkCall<T:Decodable>(_ requset:URLRequest) async throws -> T{
        do{
        let (data,response) = try await URLSession.shared.data(for: requset)
        guard let respo = response as? HTTPURLResponse else
        {
            throw NetworkError.invalidResponse
        }
        switch respo.statusCode{
        case 200...299:
            do{
                let decoder = JSONDecoder()
                    // This is the missing piece:
                    decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode(T.self, from: data)
            }catch let decodingError as DecodingError {
                switch decodingError {
                case .keyNotFound(let key, _):
                    print("Missing key: \(key.stringValue)")
                case .typeMismatch(let type, let context):
                    print("Type mismatch for \(context.codingPath.last?.stringValue ?? ""): expected \(type)")
                case .dataCorrupted(let context):
                    print("Data corrupted at: \(context.codingPath)")
                default:
                    print("Other decoding error: \(decodingError)")
                }
                throw NetworkError.decodingFailed
            }
        case 401:
            throw NetworkError.unauthorized
        default:
            throw NetworkError.serverError("Status code:\(respo.statusCode)")
        }
        }catch{
            if let urlError = error as? URLError, urlError.code == .timedOut {
                    print("Network timed out at 1.0s")
                    throw NetworkError.timeOut
                }
                print("Underlying Error: \(error)")
                throw NetworkError.serverError(error.localizedDescription)
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

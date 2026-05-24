//
//  CachedImage.swift
//  SwiftSolidPr
//
//  Created by apple on 15/05/26.
//

import Foundation
import UIKit
protocol CachedImageProtocol{
    func cachedImage(url:URL) async throws -> UIImage?
}
struct CachedImage:CachedImageProtocol{

    func cachedImage(url:URL) async throws -> UIImage?{
        let request = URLRequest(url: url)
//        if let response =  URLCache.shared.cachedResponse(for: request) {
//            if let image = UIImage(data: response.data){
//                return image
//            }
//            return nil
//        }else{
            do{
                let (data,respo) = try await URLSession.shared.data(for:request)
                guard let response = respo as? HTTPURLResponse else
                {throw NetworkError.invalidRequest}
                guard (200...299).contains(response.statusCode) else{ throw NetworkError.invalidResponse}
                let cachedRespo = CachedURLResponse(response: response, data: data)
                URLCache.shared.storeCachedResponse(cachedRespo, for: request)
                return UIImage(data: data)
            }catch{
                throw error
            }
        //}
    }
}

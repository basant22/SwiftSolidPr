//
//  NetworkManager.swift
//  SwiftSolidPr
//
//  Created by apple on 08/03/26.
//

import Foundation
import XCTest
static let baseURL = "https://"

enum HTTPType:String{
    case Get = "GET"
    case Post = "POST"
}

enum NetworkError:Error{
    case BadUrl
    case NoData
    case DecodingError
}

protocol APIDelegate{
    func fetch<T:Codeble>(type:T.self,config:ConfigRequest,onCompletion:@escaping(Result<T,NetworkError>)->void)
}

class NetworkHandler:APIDelegate{
    func fetch<T:Codeble>(type:T.self,config:ConfigRequest,onCompletion:@escaping(Result<T,NetworkError>)->void){
        private var apiHandler:ApiHandler
        private var respoHandler:ResponseHandler
        private var config:ConfigRequest
        init(apiHandler:ApiHandler = ApiHandler(),respoHandler:ResponseHandler=ResponseHandler(),config:ConfigRequest = ConfigRequest()){
            self.apiHandler = apiHandler
            self.respoHandler = respoHandler
            self.config = config
        }
        guard let urlRequest =  self.config.manageConfig(config: config) else {
            onCompletion(.failure(.BadUrl))
        }
        self.ApiHandler.fetchData(request: urlRequest, onCompletion: { result in
            switch result{
            case .success(let data):
                onCompletion(.success(data))
            case .falure(let error):
                onCompletion(.failure(.DecodingError))
            }
        })
    }
}

class ApiHandler{
    func fetchData(request:URLRequest,onCompletion:@escaping(Result<Data,NetworkError>)->){
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data , error == nil else {return}
            onCompletion(.success(data))
        }
    }
}
class ResponseHandler{
    func handleResponse<T:Codable>(type:T.Type,data:Data,onCompletion:@escaping(Result<T,NetworkError>)->void){
        do {
          var decodabl =  try JSONDecoder().decode(type.self, from: data)
            onCompletion(.success(decodabl))
        } catch  {
            onCompletion(.failure(.DecodingError))
        }
    }
}

//
//  ApiHandler.swift
//  SwiftSolidPr
//
//  Created by apple on 31/03/26.
//

import Foundation
import Combine
struct User: Decodable,Identifiable {
    let id: Int
    let name: String
    let email: String
}



protocol APIServiceProtocol {
    func fetchUsers() -> AnyPublisher<[User], Error>
}

class APIService: APIServiceProtocol {
    
    func fetchUsers() -> AnyPublisher<[User], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/users")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [User].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

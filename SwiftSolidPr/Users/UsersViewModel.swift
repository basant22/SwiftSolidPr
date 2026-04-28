//
//  UsersViewModel.swift
//  SwiftSolidPr
//
//  Created by apple on 08/03/26.
//

import Foundation
class UserViewModal{
    @Published var usersData:[UserInterfaceData] = []
    
    func fetchUser(onCompletion:@escaping(Bool,NetworkError? = nil)->()){
        let config = UserConfiguration()
        NetworkHandler().fetch(type: [UserInterfaceData], config: config) { result in
            switch result{
            case .success(let modal):
                self.usersData = modal
                onCompletion(true)
            case .failure(let error)
                onCompletion(false,error)
            }
        }
    }
}


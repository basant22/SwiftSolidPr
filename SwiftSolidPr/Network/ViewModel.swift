//
//  ViewModel.swift
//  SwiftSolidPr
//
//  Created by apple on 31/03/26.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var name:String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchUsers() {
        isLoading = true
        
        apiService.fetchUsers()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] users in
                self?.users = users
            }
            .store(in: &cancellables)
    }
}

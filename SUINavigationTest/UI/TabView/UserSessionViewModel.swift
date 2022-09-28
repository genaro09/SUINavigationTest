//
//  UserSessionViewModel.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import Combine
import Foundation

enum SessionState: Identifiable {
    case loggedIn
    case loggedOut
    case guest
    
    var id: Self {
        self
    }
}

class UserSessionViewModel: ObservableObject {
    static let userKey: String = "User"
    private let storage: UserDefaults = UserDefaults.standard
    private var cancellables: Set<AnyCancellable> = []

    @Published var flag: Bool = false
    
    let userState = PassthroughSubject<SessionState, Never>()
    var state: SessionState?
    var user: User?
    
    init() {
        userState
            .sink { [weak self] state in
                self?.state = state
            }
            .store(in: &cancellables)
    }

    func presentLogin() {
        userState.send(.loggedOut)
    }
    
    func signOut() {
        userState.send(.loggedOut)
        user = nil
        storage.removeObject(forKey: UserSessionViewModel.userKey)
    }
    
    func continueAsGuest() {
        userState.send(.guest)
    }
    
    func signIn() {
        let user = User()
        if let encoded = try? JSONEncoder().encode(user) {
            storage.set(encoded, forKey: UserSessionViewModel.userKey)
            self.user = user
            userState.send(.loggedIn)
        }
        
    }
    
    /// Validate the current session of the app
    func setUpUserSession() {        
        if let userData = storage.object(forKey: UserSessionViewModel.userKey) as? Data,
           let user = try? JSONDecoder().decode(User.self, from: userData) {
            self.user = user
            userState.send(.loggedIn)
        } else {
            userState.send(.guest)
        }
    }
}

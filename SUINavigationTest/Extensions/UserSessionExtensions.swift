//
//  UserSessionExtensions.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

extension View {
    /// Returns the new state of the current session
    ///
    /// - Returns: SessionState:
    ///   loggedIn, loggedOut and guest
    func userSession(_ state: @escaping (SessionState) -> Void) -> some View {
        self.modifier(UserSessionModifier(sessionState: state))
    }
}

struct UserSessionModifier: ViewModifier {
    @EnvironmentObject var userSession: UserSession
    @SwiftUI.State var didLoad = false
    let sessionState: (SessionState) -> Void
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if let state = userSession.state, !didLoad {
                    didLoad = true
                    sessionState(state)
                }
            }
            .onReceive(userSession.userState.removeDuplicates()) { state in
                sessionState(state)
            }
    }
}

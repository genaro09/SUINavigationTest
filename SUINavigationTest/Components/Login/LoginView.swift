//
//  LoginView.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("Colors APP")
                    .font(.title)
                    .padding(.vertical)
                
                Spacer()
                
                VStack(spacing: 16) {
                    NavigationLink(destination: SignInView()) {
                        CapsuleView(label: "SignIn")
                    }

                    CapsuleButtonView(label: "Continue as Guest") {
                        userSession.continueAsGuest()
                    }
                }
                .padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserSession())
    }
}

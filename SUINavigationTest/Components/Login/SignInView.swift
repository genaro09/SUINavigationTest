//
//  SignIn.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var userSession: UserSessionViewModel

    var body: some View {
        VStack {
            Spacer()

            Text("Sign In")
                .font(.title)
                .padding(.vertical)
            
            Spacer()
            
            CapsuleButtonView(label: "Sign In") {
                userSession.signIn()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Sign In")
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(UserSessionViewModel())
    }
}

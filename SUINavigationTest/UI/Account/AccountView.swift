//
//  AccountView.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var userSession: UserSession
    @State var sessionState: SessionState = .guest

    var body: some View {
        NavigationView {
            VStack {
                switch sessionState {
                case .loggedIn:
                    userView
                default:
                    guestView
                }
            }
            .userSession { newState in
                sessionState = newState
            }
            .navigationTitle("Account")
        }
    }
    
    var guestView: some View {
        VStack {
            CapsuleButtonView(label: "Login") {
                userSession.presentLogin()
            }
            .padding()
        }
    }
    
    var userView: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("Name:")
                        .font(.subheadline)
                    Text(userSession.user?.name ?? "")
                }
                
                HStack {
                    Text("Email:")
                        .font(.subheadline)
                    Text(userSession.user?.email ?? "")
                }
                
                HStack {
                    Text("Phone Number:")
                        .font(.subheadline)
                    Text(userSession.user?.phone ?? "")
                }
                
                HStack(alignment: .top) {
                    Text("Address:")
                        .font(.subheadline)
                    Text(userSession.user?.address ?? "")
                }
                
                HStack(alignment: .top) {
                    Text("About:")
                        .font(.subheadline)
                    Text(userSession.user?.about ?? "")
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            Spacer()
            
            CapsuleButtonView(label: "Sign Out") {
                userSession.signOut()
            }
        }
        .padding()
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
            .environmentObject(UserSession())
    }
}

//
//  ContentView.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var userSession: UserSession
    @State var isLoginFlowPresented = false

    var body: some View {
        TabView {
            ColorListView(viewModel: ColorListViewModel())
                .tabItem {
                    Label {
                        Text("Colors")
                    } icon: {
                        Image(systemName: "eyedropper.halffull")
                    }
                }
            
            FavoritesColorsView(viewModel: FavoritesColorsViewModel())
                .tabItem {
                    Label {
                        Text("Favorites")
                    } icon: {
                        Image(systemName: "star.fill")
                    }
                }
            
            AccountView()
                .tabItem {
                    Label {
                        Text("Account")
                    } icon: {
                        Image(systemName: "person.crop.circle")
                    }
                }
        }
        .fullScreenCover(isPresented: $isLoginFlowPresented) {
            LoginView()
        }
        .onReceive(userSession.userState) { state in
            switch state {
            case .loggedOut:
                isLoginFlowPresented = true
            default:
                isLoginFlowPresented = false
            }
        }
        .onAppear {
            userSession.setUpUserSession()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(UserSession())
    }
}

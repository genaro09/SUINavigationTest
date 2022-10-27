//
//  ContentView.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

/// An enum that represents the person's selection in the app's sidebar.
///
/// The `Panel` enum encodes the views the person can select in the sidebar, and hence appear in the detail view.
enum Panel: Hashable {
    case colors
    case favorites
    case account
}


struct MainTabView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var userSession: UserSession
    @State var isLoginFlowPresented = false
    @State private var selection: Panel? = Panel.colors

    @State var homePath = NavigationPath()
    @State var favorites = NavigationPath()
    @State var account = NavigationPath()

    var body: some View {
        Group {
            if horizontalSizeClass == .compact {
               // tabView
            } else {
                listView
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
    
//    var listView: some View {
//        NavigationSplitView {
//            List {
//                NavigationLink(destination: homeView) {
//                    Label("Colors", systemImage: "eyedropper.halffull")
//                }
//
//                NavigationLink(destination: FavoritesColorsView(viewModel: FavoritesColorsViewModel())) {
//                    Label("Favorites", systemImage: "star.fill")
//                }
//
//                NavigationLink(destination: AccountView()) {
//                    Label("Account", systemImage: "person.crop.circle")
//                }
//            }
//        } detail: {
//
//        }
//        .navigationTitle("Colors")
//    }

    var listView: some View {
            NavigationSplitView {
                List {
                    Button {
                        selection = .colors
                    } label: {
                        Label("Colors", systemImage: "eyedropper.halffull")
                    }


                    Button {
                        selection = .favorites
                    } label: {
                        Label("Favorites", systemImage: "star.fill")
                    }

                    Button {
                        selection = .account
                    } label: {
                        Label("Account", systemImage: "person.crop.circle")
                    }
                }
            } detail: {
                switch selection ?? .colors {
                case .colors:
                    NavigationStack(path: $homePath) {
                        ColorListView(path: $homePath, viewModel: ColorListViewModel())
                    }

                case .favorites:
                    NavigationStack(path: $favorites) {
                        FavoritesColorsView(path: $favorites, viewModel: FavoritesColorsViewModel())
                    }
                case .account:
                    NavigationStack(path: $account) {
                        AccountView()
                    }
                }
            }
            .navigationTitle("Colors")
        }
    
//    var tabView: some View {
//        TabView(selection: $selection) {
//            ColorListView(viewModel: ColorListViewModel())
//                .tabItem {
//                    Label {
//                        Text("Colors")
//                    } icon: {
//                        Image(systemName: "eyedropper.halffull")
//                    }
//                }
//
//            FavoritesColorsView(viewModel: FavoritesColorsViewModel())
//                .tabItem {
//                    Label {
//                        Text("Favorites")
//                    } icon: {
//                        Image(systemName: "star.fill")
//                    }
//                }
//
//            AccountView()
//                .tabItem {
//                    Label {
//                        Text("Account")
//                    } icon: {
//                        Image(systemName: "person.crop.circle")
//                    }
//                }
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(UserSession())
    }
}

//
//  FavoritesColors.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

struct FavoritesColorsView: View {
    @EnvironmentObject var userSession: UserSession
    @ObservedObject var viewModel: FavoritesColorsViewModel
    @State var sessionState: SessionState = .guest

    var body: some View {
        NavigationStack {
            VStack {
                switch sessionState {
                case .loggedIn:
                    favoriteList
                default:
                    guestView
                }
            }
            .userSession { newState in
                sessionState = newState
            }
            .navigationTitle("Favorites")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var guestView: some View {
        VStack {
            Text("Login First to start adding Favorites")
                .padding(.bottom, 32)

            CapsuleButtonView(label: "Login") {
                userSession.presentLogin()
            }
            .padding()
        }
    }
    
    var favoriteList: some View {
        List {
            ForEach(viewModel.colors) { color in
                NavigationLink(destination: ColorDetail(color: color)) {
                    HStack {
                        Color(hex: color.hex.value)
                            .frame(width: 100)
                            .aspectRatio(contentMode: .fill)

                        Text(color.name.value)
                            .font(.title3)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
    }
}

struct FavoritesColorsView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesColorsView(viewModel: FavoritesColorsViewModel())
    }
}

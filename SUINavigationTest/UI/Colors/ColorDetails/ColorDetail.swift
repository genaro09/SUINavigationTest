//
//  ColorDetail.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

struct ColorDetail: View {
    @EnvironmentObject var userSession: UserSessionViewModel
    @State var sessionState: SessionState = .guest
    @State var presentLoginError: Bool = false
    let color: ColorData

    var body: some View {
        VStack(alignment: .leading) {
            Color(hex: color.hex.value)
                .frame(height: 300)
                .aspectRatio(contentMode: .fill)

            VStack(alignment: .leading) {
                HStack {
                    Text("RGB:")

                    Text(color.rgb.value)
                }

                HStack {
                    Text("Hex:")

                    Text(color.hex.value)
                }
            }
            .padding()

            Spacer()

            CapsuleButtonView(label: "Add to Favorites") {
                if sessionState == .loggedIn {
                    NotificationCenter.default.post(name: FavoritesColorsViewModel.favoritesNotification, object: color)
                } else {
                    presentLoginError.toggle()
                }
            }
            .padding()
        }
        .userSession {
            sessionState = $0
        }
        .alert("Login", isPresented: $presentLoginError) {
            Button("Login", action: { userSession.presentLogin() })
            Button("Cancel", role: .cancel, action: {})
        } message: {
            Text("Please Login first")
        }
        .navigationTitle(color.name.value)
    }
}

struct ColorDetail_Previews: PreviewProvider {
    static var previews: some View {
        ColorDetail(
            color: ColorData(
                hex: .init(value: "#000000", clean: "000000"),
                name: .init(value: "Black"),
                image: .init(bare: "https://www.thecolorapi.com/id?format=svg&named=false&hex=125A72", named: ""),
                rgb: .init(value: "rgb(0,0,0)", r: 0, g: 0, b: 0)
            )
        )
        .environmentObject(UserSessionViewModel())
    }
}

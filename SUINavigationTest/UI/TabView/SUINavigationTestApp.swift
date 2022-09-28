//
//  SUINavigationTestApp.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

@main
struct SUINavigationTestApp: App {
    @StateObject var session = UserSessionViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView(viewModel: session)
        }
    }
}

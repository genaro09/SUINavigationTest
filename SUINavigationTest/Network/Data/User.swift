//
//  User.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import Foundation

struct User: Codable {
    let name: String
    let email: String
    let phone: String
    let address: String
    let about: String
    var favorites = [String]()

    init(
        name: String = "Nancy Elliott",
        email: String = "nancyelliott@outlook.com",
        phone: String = "+1 (857) 448-2570",
        address: String = "105 Ashland Place, Brownlee, South Carolina, 732",
        about: String =
            "Enim adipisicing enim et eiusmod consequat ad duis sunt in ut dolore ipsum. Qui qui do Lorem ipsum veniam. Ut ex irure voluptate deserunt ipsum excepteur laborum. Voluptate tempor cillum dolore et. Enim eiusmod eu mollit aute consequat. Exercitation consectetur irure deserunt cillum et enim anim commodo sunt excepteur. Fugiat ipsum aliqua cillum laborum deserunt voluptate voluptate in reprehenderit occaecat sit",
        favorites: [String] = [String]()
    ) {
        self.name = name
        self.email = email
        self.phone = phone
        self.address = address
        self.about = about
        self.favorites = favorites
    }
}

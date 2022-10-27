//
//  Color.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

struct Colors: Decodable, Hashable {
    let colors: [ColorData]
}

struct ColorData: Decodable, Hashable {
    let hex: ColorHex
    let name: ColorName
    let image: ColorImage
    let rgb: RGB
    
    struct ColorHex: Decodable, Hashable {
        let value: String
        let clean: String
    }

    struct ColorName: Decodable, Hashable {
        let value: String
    }

    struct ColorImage: Decodable, Hashable {
        let bare: String
        let named: String
    }

    struct RGB: Decodable, Hashable {
        let value: String
        let r: Int
        let g: Int
        let b: Int
    }
}

extension ColorData: Identifiable {
    var id: String {
        hex.value
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

//
//  CapsuleButtonView.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

struct CapsuleButtonView: View {
    let label: String
    var action: () -> Void

    init(
        label: String,
        action: @escaping () -> Void
    ) {
        self.label = label
        self.action = action
    }

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Capsule()
                    .foregroundColor(.accentColor)
                    .overlay(
                        Capsule()
                            .stroke(lineWidth: 1)
                            .foregroundColor(.accentColor)
                            .padding(1)
                    )

                HStack(alignment: .center) {
                    Text(label)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.headline)
                        .lineLimit(1)
                }
                .padding(DrawingConstants.padding)
            }
            .clipped()
        }
        .frame(height: 44)
    }
}

extension CapsuleButtonView {
    private struct DrawingConstants {
        static let padding: CGFloat = 12
    }
}

struct CapsuleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CapsuleButtonView(
                label: "Action",
                action: {
                    // action
                }
            )
        }
    }
}

struct CapsuleView: View {
    let label: String

    var body: some View {
        ZStack {
            Capsule()
                .foregroundColor(.accentColor)
                .overlay(
                    Capsule()
                        .stroke(lineWidth: 1)
                        .foregroundColor(.accentColor)
                        .padding(1)
                )

            HStack(alignment: .center) {
                Text(label)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.headline)
                    .lineLimit(1)
            }
            .padding(12)
        }
        .clipped()
        .frame(height: 44)
    }
}

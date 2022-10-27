//
//  ColorListView.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

struct ColorListView: View {
    @Binding var path: NavigationPath
    @StateObject var viewModel: ColorListViewModel

    var body: some View {
        List {
            ForEach(viewModel.colors) { color in
                HStack {
                    Color(hex: color.hex.value)
                        .frame(width: 100)
                        .aspectRatio(contentMode: .fill)

                    Text(color.name.value)
                        .font(.title3)
                }
                .padding(.vertical, 4)
                .onTapGesture {
                    path.append(color)
                }
            }
        }
        .navigationDestination(for: ColorData.self) { color in
            ColorDetail(color: color)
        }
        .onAppear(perform: viewModel.fetchColors)
        .navigationTitle("Colors")
        .navigationBarTitleDisplayMode(.inline)
    }
}
//
//struct ColorListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ColorListView(path: .constant(.init()), viewModel: ColorListViewModel())
//    }
//}

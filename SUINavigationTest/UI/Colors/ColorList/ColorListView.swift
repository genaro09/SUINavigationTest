//
//  ColorListView.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import SwiftUI

struct ColorListView: View {
    @ObservedObject var viewModel: ColorListViewModel

    var body: some View {
        NavigationView {
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
            .onAppear(perform: viewModel.fetchColors)
            .navigationTitle("Colors")
        }
    }
}

struct ColorListView_Previews: PreviewProvider {
    static var previews: some View {
        ColorListView(viewModel: ColorListViewModel())
    }
}

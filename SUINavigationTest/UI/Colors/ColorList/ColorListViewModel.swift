//
//  ColorListViewModel.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import Combine

class ColorListViewModel: ObservableObject {
    @Published var colors = [ColorData]()
    @Published var isLoading = false
    @Published var error: Error?

    let service: ColorsFetcher
    var requstCancellable: AnyCancellable?

    init(service: ColorsFetcher = ColorService()) {
        self.service = service
    }

    func fetchColors() {
        requstCancellable = service.fetchColors()
            .sink(
                receiveCompletion: { [weak self] result in
                    if case let .failure(error) = result {
                        self?.error = error
                    }
                },
                receiveValue: { [weak self] colors in
                    self?.colors = colors
                }
            )
    }
}

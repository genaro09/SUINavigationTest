//
//  FavoritesColorsViewModel.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import Combine
import NotificationCenter

class FavoritesColorsViewModel: ObservableObject {
    static let favoritesNotification = Notification.Name("FavoritesNotification")

    @Published var colors = [ColorData]()

    private var cancellables: Set<AnyCancellable> = []
    let favoritesNotification = NotificationCenter.default.publisher(for: FavoritesColorsViewModel.favoritesNotification)
    
    init() {
        setupBindings()
    }
        
    private func setupBindings() {
        favoritesNotification
            .compactMap { $0.object as? ColorData}
            .sink { [weak self] color in
                let exist = self?.colors.contains(where: { $0.id == color.id }) ?? false
                exist ? self?.colors.removeAll(where: { $0.id == color.id }) : self?.colors.append(color)
            }
            .store(in: &cancellables)
    }
}

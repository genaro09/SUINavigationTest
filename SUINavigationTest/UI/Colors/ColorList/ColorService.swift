//
//  ColorService.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import Combine
import Foundation

// The usage of Protocols on the services is so we can change the source of the data without changing the view models
protocol ColorsFetcher {
    func fetchColors() -> AnyPublisher<[ColorData], NetworkRequestError>
}

struct ColorService: ColorsFetcher {
    let requester = Requester()
    
    func fetchColors() -> AnyPublisher<[ColorData], NetworkRequestError> {
        let result: Result<Colors, NetworkRequestError> = requester.loadJson(filename: "Colors")
        switch result {
        case .success(let colorsData):
            return Just(colorsData.colors)
                .setFailureType(to: NetworkRequestError.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
        
    }
}

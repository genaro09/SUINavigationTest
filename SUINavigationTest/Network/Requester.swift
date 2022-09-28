//
//  Networking.swift
//  SUINavigationTest
//
//  Created by Genaro Alvarenga on 9/27/22.
//

import Foundation

public enum NetworkRequestError: Error {
    case fileNotFound
    case error(Error)
}

struct Requester {
    func loadJson<T: Decodable>(filename fileName: String) -> Result<T, NetworkRequestError> {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(T.self, from: data)
                return .success(jsonData)
            } catch {
                return .failure(.error(error))
            }
        }
        return .failure(.fileNotFound)
    }
}


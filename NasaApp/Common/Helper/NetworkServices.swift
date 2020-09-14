//
//  NetworkServices.swift
//  NasaApp
//
//  Created by Juan Camilo on 13/09/20.
//  Copyright © 2020 Juan Camilo. All rights reserved.
//

import Foundation

public enum APIServiceError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case decodeError
}

class NetworkServices {
    static let share = NetworkServices()
    private let urlSession = URLSession.shared
    
    private var baseUrl: URL? {
        return URL(string: Configuration.shared.getValueConfiguration(withType: String.self, key: .baseUrl) ?? "")
    }
    
    var queryUrl: [URLQueryItem] = {
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: ApplicationConstants.apiKeyPath, value: Configuration.shared.getValueConfiguration(withType: String.self, key: .publicKey)))
        return items
    }()
    
    func get<T: Codable>(type: T.Type,
                         date: String,
                         completion: @escaping (Result<T, APIServiceError>) -> ()) {
        
        guard let url = baseUrl, var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        queryUrl.append(URLQueryItem(name: ApplicationConstants.datePath, value: date))
        
        urlComponents.queryItems = queryUrl
        
        guard let completeUrl = urlComponents.url else {
            completion(.failure(.invalidEndpoint))
            return
        }
        
        urlSession.dataTask(with: completeUrl) { (data, response, error)  in
            guard let data = data, let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let values = try JSONDecoder().decode(T.self, from: data)
                completion(.success(values))
            } catch {
                completion(.failure(.decodeError))
            }
        }.resume()
    }
}

//
//  CryptoDataLoader.swift
//  CryptoTracker
//
//  Created by Cristina Dobson on 2/25/23.
//

import Foundation
import Combine

class CryptoDataLoader: CryptoService {
  
  
  // MARK: - Properties
  
  static let shared = CryptoDataLoader()
  private let apiKeyName = "X-API-Token"
  private let apiKey = "8bed177a-5d93-42fe-bfcd-909375142121"
  private let baseApiURL = "https://api.blockchain.com/v3/exchange/"
  private let urlSession = URLSession.shared
  private var subscriptions = Set<AnyCancellable>()
  
  private let jsonDecoder: JSONDecoder = {
    let jsonDecoder = JSONDecoder()
    return jsonDecoder
  }()
  
  
  // MARK: - Init method
  
  private init() {}
  
  
  // MARK: - CryptoService protocol
  
  func fetchCryptoMarkets<T: Codable>(from endpoint: String) -> Future<T, CryptoDataAPIError> {//[CryptoMarket]
    
    // Initialize and return Future
    return Future<T, CryptoDataAPIError> { [unowned self] promise in
      //Future<[CryptoMarket], CryptoDataAPIError> { [unowned self] promise in
      guard let url = self.createURL(with: endpoint)
      else {
        return promise(.failure(.urlError(URLError(.unsupportedURL))))
      }
      
      // Fetch data
      self.urlSession.dataTaskPublisher(for: url)
      /*
       Check that the http
       response status code is between 200 and 300.
       */
        .tryMap { (data, response) -> Data in
          guard let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode
          else {
            throw CryptoDataAPIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
          }
          return data
        }
      /*
       Decode the published JSON data into CryptoDataModel
       */
        .decode(type: T.self,
                decoder: self.jsonDecoder)
//        .decode(type: [CryptoMarket].self,
//                decoder: self.jsonDecoder)
      /*
       Make sure completion runs on the main thread
       */
        .receive(on: RunLoop.main)
      /*
       Subscribe to receive a value
       */
        .sink { completion in
          if case let .failure(error) = completion {
            switch error {
              case let urlError as URLError:
                promise(.failure(.urlError(urlError)))
              case let decodingError as DecodingError:
                promise(.failure(.decodingError(decodingError)))
              case let apiError as CryptoDataAPIError:
                promise(.failure(apiError))
              default:
                promise(.failure(.anyError))
            }
          }
        }
    receiveValue: {
      promise(.success($0))
    }
      /*
       Make sure the subscription still works after
       the execution is finished.
       */
    .store(in: &self.subscriptions)
      
    }
  }
  
  
  // MARK: - Create Endpoint
  
  private func createURL(with endpoint: String) -> URL? {
    
    guard var urlComponents = URLComponents(string: "\(baseApiURL)/\(endpoint)")
    else { return nil }
    
    let queryItems = [URLQueryItem(name: apiKeyName,
                                   value: apiKey)]
    urlComponents.queryItems = queryItems
    return urlComponents.url
  }
  
}




















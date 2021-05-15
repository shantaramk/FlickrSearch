//
//  WebService.swift
//  FlickrSearch
//
//  Created by Dkatalis on 14/05/21.
//

import Foundation

protocol IWebService {
    func performRequest<T: Decodable>(_ path: String,
                        successHandler: @escaping(T) -> Void,
                        failureHandler: @escaping(Error?) -> Void)
}

protocol APIRequestable: IWebService {}

final class APIManager: APIRequestable {
    func performRequest<T>(_ path: String,
                           successHandler: @escaping (T) -> Void,
                           failureHandler: @escaping (Error?) -> Void) where T : Decodable {
        
        let sessionConfigure = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfigure)
        guard let url = URL(string: String(format: "%@%@", Domain.development, path)) else { return }
        debugPrint("API Request: ", url)
        let urlRequest = URLRequest(url: url)
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let jsonModel = try JSONDecoder().decode(T.self, from: data)
                        successHandler(jsonModel)
                    } catch let error {
                        debugPrint("Parsing Error:", error)
                        failureHandler(error)
                    }
                } else {
                    failureHandler(nil)
                }
            }
        }.resume()
         
    }
}

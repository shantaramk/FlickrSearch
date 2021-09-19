//
//  WebService.swift
//  FlickrSearch
//
//  Created by Shantaram Kokate on 14/05/21.
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
                
                if let _ = error{
                    let errorType = NetworkError.other(message: error?.localizedDescription)
                    failureHandler(errorType)
                    return
                }
                
                guard let responseData = response as? HTTPURLResponse,
                      let receivedData = data else{
                    let errorType = NetworkError.noResponseData
                    failureHandler(errorType)
                    return
                }
                
                let responseStatus = self.isValidResponse(response: responseData)
                switch responseStatus {
                case .success:
                    do {
                        let jsonModel = try JSONDecoder().decode(T.self, from: receivedData)
                        successHandler(jsonModel)
                    } catch let error {
                        debugPrint("Parsing Error:", error)
                        failureHandler(NetworkError.unableToDecodeResponseData(errorDescription: error.localizedDescription))
                        
                    }
                case .failure(let error):
                    let errorType = NetworkError.other(message: error.localizedDescription)
                    failureHandler(errorType)
                }
            }
        }.resume()
        
    }
    
    func isValidResponse(response: HTTPURLResponse) -> Result<String, NetworkError>{
        switch response.statusCode{
        case 200...299:
            return .success("Valid Response")
        case 401:
            return .failure(NetworkError.authenticationError)
        case 500:
            return .failure(NetworkError.badRequest)
        default:
            return .failure(NetworkError.failed)
        }
    }
    
}

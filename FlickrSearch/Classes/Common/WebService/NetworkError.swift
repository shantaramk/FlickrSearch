//
//  NetworkError.swift
//  FlickrSearch
//
//  Created by Shantaram on 20/09/21.
//

import Foundation

public enum NetworkError: Error {
    case parametersNil
    case parameterEncodingFailed
    case malformedURL
    case authenticationError
    case badRequest
    case failed
    case noResponseData
    case unableToDecodeResponseData(errorDescription: String)
    case other(message: String?)
    
    var localizedDescription: String{
        var message: String = ""
        
        switch self{
        case .parametersNil:
            message = "Empty parameteres"
        case .parameterEncodingFailed:
            message = "Failed to encode request parameters"
        case .malformedURL:
            message = "Malformed URL"
        case .authenticationError:
            message = "Authenticatioon failed"
        case .badRequest:
            message = "Bad request"
        case .failed:
            message = "API request failed"
        case .noResponseData:
            message = "Empty response data"
        case .unableToDecodeResponseData:
            message = "Unable to decode response object"
        case let .other(errorMessage):
            message = errorMessage ?? ""
        }
        return message
    }
    
    func getFormattedError(message: String) -> String{
        let trimmedMessage: String = "Error: \(message.trimmingCharacters(in: .whitespacesAndNewlines))"
        return trimmedMessage
    }
}

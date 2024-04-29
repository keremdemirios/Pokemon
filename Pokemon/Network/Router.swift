//
//  Constant.swift
//  Pokemon
//
//  Created by Kerem Demir on 13.04.2024.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case getNames
    case getImages(url: String)
    case getAbilities(url: String)
    
    var method: HTTPMethod {
        switch self {
        case .getNames, .getImages, .getAbilities:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getNames, .getImages, .getAbilities:
            return nil
        }
    }
    
    var encoding: ParameterEncoding {
        JSONEncoding.default
    }
    
    var url: URL {
        switch self {
        case .getNames:
            return URL(string: Constants.getNames)!
            
        case .getImages(let url):
            return URL(string: url)!
            
        case .getAbilities(let url):
            return URL(string: url)!
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
}


//
//  WebService.swift
//  Pokemon
//
//  Created by Kerem Demir on 13.04.2024.
//

import Foundation
import Alamofire

final class WebService {
    
    static let shared: WebService = {
        let instance = WebService()
        return instance
    }()
    
    func request<T: Decodable>(request: URLRequestConvertible, decodedType type: T.Type, completionHandler: @escaping (Result<T, Error>) -> Void) {
        
        AF.request(request).responseData { [weak self] response in
            guard let self else { return }
            
            switch response.result {
            case .success(let data):
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(decodedData))
                } catch {
                    print("Json Decode Error : \(error.localizedDescription)")
                }
            case .failure(let error):
                completionHandler(.failure(error.localizedDescription as! Error))
            }
        }
    }
}

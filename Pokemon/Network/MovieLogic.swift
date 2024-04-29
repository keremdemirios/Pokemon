//
//  MovieLogic.swift
//  Pokemon
//
//  Created by Kerem Demir on 13.04.2024.
//

import Foundation

final class MovieLogic: MovieLogicProtocol {
    
    // MARK: Shared
    static let shared: MovieLogic = {
        let instance = MovieLogic()
        return instance
    }()
    
    // MARK: Protocols from MovieLogicProtocol
    func getPokemonDetails(url: String, completionHandler: @escaping (Result<PokemonDetail, Error>) -> Void) {
        WebService.shared.request(request: Router.getImages(url: url), decodedType: PokemonDetail.self, completionHandler: completionHandler)
    }
    
    func getPokemonAbilities(url: String, completionHandler: @escaping (Result<PokemonDetail, Error>) -> Void) {
        WebService.shared.request(request: Router.getAbilities(url: url), decodedType: PokemonDetail.self, completionHandler: completionHandler)
    }

    func getPokemonNames(completionHandler: @escaping (Result<PokemonName, Error>) -> Void) {
        WebService.shared.request(request: Router.getNames, decodedType: PokemonName.self, completionHandler: completionHandler)
    }

}


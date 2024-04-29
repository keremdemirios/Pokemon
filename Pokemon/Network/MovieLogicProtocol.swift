//
//  MovieLogicProtocol.swift
//  Pokemon
//
//  Created by Kerem Demir on 13.04.2024.
//

import Foundation

protocol MovieLogicProtocol {
    func getPokemonNames(completionHandler: @escaping (Result<PokemonName, Error>) -> Void)
    
    func getPokemonDetails(url: String, completionHandler: @escaping (Result<PokemonDetail, Error>) -> Void)
    
    func getPokemonAbilities(url: String, completionHandler: @escaping (Result<PokemonDetail, Error>) -> Void)
}

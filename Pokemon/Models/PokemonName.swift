//
//  PokemonName.swift
//  Pokemon
//
//  Created by Kerem Demir on 13.04.2024.
//

import Foundation

// MARK: Pokemon Name Model
struct PokemonName: Decodable {

    let count: Int
    let next: String
    let previous: String?
    let results: [PokemonResults]?
    
}

struct PokemonResults: Decodable {
    let name: String?
    let url: String?
    
    var _name: String {
        name ?? "N/A Name for PokemonNameModel"
    }
    
    var _url: String {
        url ?? "N/A Url for PokemonNameModel"
    }
}

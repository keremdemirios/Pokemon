//
//  Constants.swift
//  Pokemon
//
//  Created by Kerem Demir on 13.04.2024.
//

import Foundation

struct Constants {
    static let getNames        : String = "https://pokeapi.co/api/v2/pokemon?limit=40&offset=0"
    static let getDetail       : String = "https://pokeapi.co/api/v2/pokemon/"
    static let getAbilities    : String = "https://pokeapi.co/api/v2/pokemon/"
    
    
    static func imageUrl(path: Int) -> String {
        return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(path).png"
    }
    
    static func getDetail(forID id: Int) -> String {
        return "\(getDetail)\(id)/"
    }
    
    static func getAbilities(forID id: Int) -> String {
        return "\(getAbilities)\(id)/"
    }
}

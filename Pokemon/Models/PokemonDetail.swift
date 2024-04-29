//
//  PokemonDetail.swift
//  Pokemon
//
//  Created by Kerem Demir on 13.04.2024.
//

import Foundation

// MARK: - PokemonDetail
struct PokemonDetail: Decodable {
    let id: Int?
    let name: String?
    let sprites: Sprites?
    let abilities: [AbilityElement]

    enum CodingKeys: String, CodingKey {
        case id, name, sprites, abilities
    }
}

// MARK: Abilities
struct AbilityElement: Decodable {
    let ability: AbilityAbility
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability, slot
    }
}

// MARK: - AbilityAbility
struct AbilityAbility: Decodable {
    let name: String
    let url: String
}

// MARK: - Sprites
struct Sprites: Decodable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
    
    var _frontDefault: String {
        frontDefault ?? "N/A FrontDefault Value"
    }
}

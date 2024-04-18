//
//  GamesRepositoryProtocol.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation

protocol GamesRepositoryProtocol {
    func gamesList() throws -> [Game]
    func saveGame(game: Game)
}

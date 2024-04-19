//
//  GameUseCaseProtocol.swift
//  FourDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation

protocol GameUseCaseProtocol {
    func gamesList() throws -> [Game]
    func saveGame(game: Game)
}

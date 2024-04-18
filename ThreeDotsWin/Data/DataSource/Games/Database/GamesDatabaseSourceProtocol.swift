//
//  GamesDatabaseSourceProtocol.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation

protocol GamesDatabaseSourceProtocol {
    func gamesList() throws -> [SDGame]
    func saveGame(game: Game)
}

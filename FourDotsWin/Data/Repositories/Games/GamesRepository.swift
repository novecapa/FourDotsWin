//
//  GamesRepository.swift
//  FourDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation

final class GamesRepository: GamesRepositoryProtocol {

    let databaseSource: GamesDatabaseSourceProtocol
    init(databaseSource: GamesDatabaseSourceProtocol) {
        self.databaseSource = databaseSource
    }

    func gamesList() throws -> [Game] {
        try databaseSource.gamesList().map { $0.toEntity }
    }

    func saveGame(game: Game) {
        databaseSource.saveGame(game: game)
    }
}

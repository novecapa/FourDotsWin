//
//  GameUseCase.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation

final class GameUseCase: GameUseCaseProtocol {

    let repository: GamesRepositoryProtocol
    init(repository: GamesRepositoryProtocol) {
        self.repository = repository
    }

    func gamesList() throws -> [Game] {
        try repository.gamesList()
    }

    func saveGame(game: Game) {
        repository.saveGame(game: game)
    }
}

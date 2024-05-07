//
//  GameViewBuilder.swift
//  FourDotsWin
//
//  Created by Josep Cerdá Penadés on 17/4/24.
//

import Foundation

final class GameViewBuilder {
    func build() -> GameView {
        let databaseSource = GamesDatabaseSource()
        let repository = GamesRepository(databaseSource: databaseSource)
        let useCase = GameUseCase(repository: repository)
        let viewModel = GameViewModel(useCase: useCase)
        let view = GameView(viewModel: viewModel)
        return view
    }
}

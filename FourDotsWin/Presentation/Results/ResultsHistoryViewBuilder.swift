//
//  ResultsHistoryViewBuilder.swift
//  FourDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation

final class ResultsHistoryViewBuilder {
    func build() -> ResultsHistoryView {
        let databaseSource = GamesDatabaseSource()
        let repository = GamesRepository(databaseSource: databaseSource)
        let useCase = GameUseCase(repository: repository)
        let viewModel = ResultsHistoryViewModel(useCase: useCase)
        let view = ResultsHistoryView(viewModel: viewModel)
        return view
    }
}

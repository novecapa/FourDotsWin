//
//  ResultsHistoryViewBuilder.swift
//  FourDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation

final class ResultsHistoryViewBuilder {
    func build(viewModel: ResultsHistoryViewModel?) -> ResultsHistoryView {
        let databaseSource = GamesDatabaseSource()
        let repository = GamesRepository(databaseSource: databaseSource)
        let useCase = GameUseCase(repository: repository)
        viewModel?.useCase = useCase
        let view = ResultsHistoryView(viewModel: viewModel ?? ResultsHistoryViewModel())
        return view
    }
}

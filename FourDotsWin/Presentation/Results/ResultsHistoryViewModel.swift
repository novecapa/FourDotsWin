//
//  ResultsHistoryViewModel.swift
//  FourDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import SwiftUI

@Observable
final class ResultsHistoryViewModel {

    var games: [Game] = []
    
    private let useCase: GameUseCaseProtocol
    init(useCase: GameUseCaseProtocol) {
        self.useCase = useCase
    }

    func getResultHistory() {
        do {
            games = try useCase.gamesList()
        } catch {
            print(error.localizedDescription)
        }
    }
}

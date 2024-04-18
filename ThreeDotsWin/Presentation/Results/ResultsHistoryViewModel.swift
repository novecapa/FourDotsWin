//
//  ResultsHistoryViewModel.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation
import SwiftUI

final class ResultsHistoryViewModel: ObservableObject {

    @Published var games: [Game] = []
    var useCase: GameUseCaseProtocol?

    func getResultHistory() {
        do {
            games = try useCase?.gamesList() ?? []
        } catch {
            print(error.localizedDescription)
        }
    }
}

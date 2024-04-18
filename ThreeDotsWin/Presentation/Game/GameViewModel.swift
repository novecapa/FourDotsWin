//
//  GameViewModel.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 17/4/24.
//

import Foundation
import SwiftUI

final class GameViewModel: ObservableObject {

    enum Constants {
        static let winPatterns: Set<Set<Int>> = [
            // Horizontal
            [0, 1, 2, 3], [1, 2, 3, 4], [2, 3, 4, 5],
            [6, 7, 8, 9], [7, 8, 9, 10], [8, 9, 10, 11],
            [12, 13, 14, 15], [13, 14, 15, 16], [14, 15, 16, 17],
            [18, 19, 20, 21], [19, 20, 21, 22], [20, 21, 22, 23],
            [24, 25, 26, 27], [25, 26, 27, 28], [26, 27, 28, 29],
            [30, 31, 32, 33], [31, 32, 33, 34], [32, 33, 34, 35],
            // Vertical
            [0, 6, 12, 18], [6, 12, 18, 24], [12, 18, 24, 30],
            [1, 7, 13, 19], [7, 13, 19, 25], [13, 19, 25, 31],
            [2, 8, 14, 20], [8, 14, 20, 26], [14, 20, 26, 32],
            [3, 9, 15, 21], [9, 15, 21, 27], [15, 21, 27, 33],
            [4, 10, 16, 22], [10, 16, 22, 28], [16, 22, 28, 34],
            [5, 11, 17, 23], [11, 17, 23, 29], [17, 23, 29, 35],
            // Diagonal
            [0, 7, 14, 21], [1, 8, 15, 22], [2, 9, 16, 23], [3, 10, 17, 24],
            [6, 13, 20, 27], [7, 14, 21, 28], [8, 15, 22, 29], [9, 16, 23, 30],
            [12, 19, 26, 33], [13, 20, 27, 34], [14, 21, 28, 35], [15, 22, 29, 36],
            [3, 8, 13, 18], [4, 9, 14, 19], [5, 10, 15, 20], [6, 11, 16, 21],
            [9, 14, 19, 24], [10, 15, 20, 25], [11, 16, 21, 26], [12, 17, 22, 27],
            [15, 20, 25, 30], [16, 21, 26, 31], [17, 22, 27, 32], [18, 23, 28, 33]
        ]

        static let centerSquare: [Int] = [14, 15, 20, 21]

        static let gridItems: [GridItem] = Array(repeating: GridItem(.flexible()), count: 6)

        static let totalPositions: Int = 36

        static let iosPlayIn: CGFloat = 0.5
    }

    @Published var plays: [Play?] = Array(repeating: nil, count: Constants.totalPositions)
    @Published var isBoardDisabled: Bool = false
    @Published var alertItem: AlertItem?
    var useCase: GameUseCaseProtocol?
    private var game: Game?

    func checkPlay(item position: Int) {
        guard !isSquareOccupied(plays: plays, index: position) else { return }
        plays[position] = Play(player: .human, index: position)
        isBoardDisabled = true

        if checkWinConditions(player: .human, plays: plays) {
            alertItem = humanWinAlert
            endGame(winner: .human)
            return
        }
        if checkForDraw(plays: plays) {
            alertItem = nobodyWinAlert
            endGame(winner: nil)
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.iosPlayIn) { [weak self] in
            guard let self else { return }
            let computerPosition = self.determinateComputerPosition(plays: plays)
            plays[computerPosition] = Play(player: .machine, index: computerPosition)
            isBoardDisabled = false
            if checkWinConditions(player: .machine, plays: plays) {
                alertItem = machineWinAlert
                endGame(winner: .machine)
                return
            }
            if checkForDraw(plays: plays) {
                alertItem = nobodyWinAlert
                endGame(winner: nil)
                return
            }
        }
    }

    func startGame() {
        saveGame()
        isBoardDisabled = false
        plays = Array(repeating: nil, count: totalPositions)
    }

    func resetGame() {
        endGame(winner: nil)
        startGame()
    }

    var totalPositions: Int {
        Constants.totalPositions
    }

    var gridItems: [GridItem] {
        Constants.gridItems
    }

    var columns: CGFloat {
        CGFloat(gridItems.count)
    }
}
// MARK: Game results persistence
extension GameViewModel {
    private func saveGame() {
        game = Game(id: UUID(), startDate: Date(), endDate: Date(), winner: nil)
        guard let game else { return }
        useCase?.saveGame(game: game)
    }

    private func endGame(winner: Player?) {
        if var game {
            game.endDate = Date()
            game.winner = winner?.rawValue
            useCase?.saveGame(game: game)
        }
        game = nil
    }
}
// MARK: Alerts
private extension GameViewModel {
    private var humanWinAlert: AlertItem {
        AlertHelper(title: "You Win!".localized(),
                    message: "Can you win so fast?",
                    buttonTitle: "Start new game".localized()).alertItem
    }

    private var nobodyWinAlert: AlertItem {
        AlertHelper(title: "Anybody win...".localized(),
                    message: "Play again 🥹",
                    buttonTitle: "Start new game".localized()).alertItem
    }

    private var machineWinAlert: AlertItem {
        AlertHelper(title: "Machine Win!".localized(),
                    message: "The machine is to smart than you...",
                    buttonTitle: "Start new game".localized()).alertItem
    }
}
// MARK: Game logic
private extension GameViewModel {
    private func isSquareOccupied(plays: [Play?], index: Int?) -> Bool {
        guard let index else { return false }
        return plays.contains(where: { $0?.index == index })
    }

    private func determinateComputerPosition(plays: [Play?]) -> Int {

        // If AI can win, then win
        let computerMoves = plays.compactMap { $0 }.filter { $0.player == .machine }
        let computerPositions = Set(computerMoves.map { $0.index })
        if let missingIndex = findMissingIndex(plays: plays,
                                               in: Array(computerPositions)) {
            return missingIndex
        }

        // If AI can't win, then block
        let humanPlays = plays.compactMap { $0 }.filter({ $0.player == .human })
        let humanPositions = Set(humanPlays.map { $0.index })
        if let missingIndex = findMissingIndex(plays: plays,
                                               in: Array(humanPositions)) {
            return missingIndex
        }

        // If AI can't block, then take middle square
        if let centerSquare = Constants.centerSquare.randomElement(),
           !isSquareOccupied(plays: plays, index: centerSquare) {
            return centerSquare
        }

        // If AI can't take middle square, take random available square
        var playPosition = Int.random(in: 0..<totalPositions)
        while isSquareOccupied(plays: plays, index: playPosition) {
            playPosition = Int.random(in: 0..<totalPositions)
        }
        return playPosition
    }

    private func checkWinConditions(player: Player, plays: [Play?]) -> Bool {
        // Remove nil and check play
        let plays = plays.compactMap { $0 }.filter { $0.player == player }
        // : Comment this line
        let playerPositions = Set(plays.map { $0.index })
        // : Comment this line
        guard playerPositions.count > 3 else { return false }
        if hasConsecutiveFour(in: Array(playerPositions)) {
            return true
        }
        return false
    }

    private func checkForDraw(plays: [Play?]) -> Bool {
        plays.compactMap { $0 }.count == totalPositions
    }

    func hasConsecutiveFour(in positions: [Int]) -> Bool {
        for pattern in Constants.winPatterns where pattern.isSubset(of: positions) {
            return true
        }
        return false
    }

    func findMissingIndex(plays: [Play?], in positions: [Int]) -> Int? {
        for pattern in Constants.winPatterns {
            let missingIndex = pattern.subtracting(positions)
            if missingIndex.count == 1 &&
                !isSquareOccupied(plays: plays, index: missingIndex.first) {
                return missingIndex.first
            }
        }
        return nil
    }
}

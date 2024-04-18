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
            [0, 1, 2, 3, 4, 5],
            [6, 7, 8, 9, 10, 11],
            [12, 13, 14, 15, 16, 17],
            [18, 19, 20, 21, 22, 23],
            [24, 25, 26, 27, 28, 29],
            [30, 31, 32, 33, 34, 35],
            // Vertical
            [0, 6, 12, 18, 24, 30],
            [1, 7, 13, 19, 25, 31],
            [2, 8, 14, 20, 26, 32],
            [3, 9, 15, 21, 27, 33],
            [4, 10, 16, 22, 28, 34],
            [5, 11, 17, 23, 29, 35],
            // Diagonal
            [0, 7, 14, 21, 28, 35],
            [5, 10, 15, 20, 25, 30]
        ]
        static let centerSquare: Int = 15

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
        do {
            let res = try useCase?.gamesList()
            print("\(res?.count ?? 0)")
        } catch {
            print("\(error.localizedDescription)")
        }
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
    private func isSquareOccupied(plays: [Play?], index: Int) -> Bool {
        plays.contains(where: { $0?.index == index })
    }

    private func determinateComputerPosition(plays: [Play?]) -> Int {

        // If AI can win, then win
        let computerMoves = plays.compactMap { $0 }.filter { $0.player == .machine }
        let computerPositions = Set(computerMoves.map { $0.index })
        for pattern in Constants.winPatterns {
            let winPositions = pattern.subtracting(computerPositions)

            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(plays: plays, index: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }

        // If AI can't win, then block
        let humanPlays = plays.compactMap { $0 }.filter({ $0.player == .human })
        let humanPositions = Set(humanPlays.map { $0.index })
        for pattern in Constants.winPatterns {
            let winPositions = pattern.subtracting(humanPositions)

            if winPositions.count == 1 {
                let isAvailable = !isSquareOccupied(plays: plays, index: winPositions.first!)
                if isAvailable { return winPositions.first! }
            }
        }

        // If AI can't block, then take middle square
        if !isSquareOccupied(plays: plays, index: Constants.centerSquare) {
            return Constants.centerSquare
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
        for pattern in Constants.winPatterns where pattern.isSubset(of: playerPositions) { return true }

        /**
         return Constants.winPatterns.contains { $0.isSubset(of: playerPositions) }
         */

        return false
    }

    private func checkForDraw(plays: [Play?]) -> Bool {
        plays.compactMap { $0 }.count == totalPositions
    }
}

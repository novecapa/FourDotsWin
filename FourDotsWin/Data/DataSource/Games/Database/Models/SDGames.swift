//
//  SDGames.swift
//  FourDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation
import SwiftData

@Model
class SDGame {
    @Attribute(.unique) var id: UUID
    var startDate: Date
    var endDate: Date
    var winner: String?
    var endGame: Bool

    init(id: UUID, startDate: Date, endDate: Date, winner: String?, endGame: Bool) {
        self.id = id
        self.startDate = startDate
        self.endDate = endDate
        self.winner = winner
        self.endGame = endGame
    }
}

extension SDGame {
    var duration: Double {
        endDate.timeIntervalSince(startDate)
    }

    var winnerName: Player? {
        switch winner {
        case "human":
            .human
        case "machine":
            .machine
        default:
            nil
        }
    }
}
// MARK: Mapper
extension SDGame {
    var toEntity: Game {
        Game(id: id,
             startDate: startDate,
             endDate: endDate,
             winner: winner,
             endGame: endGame)
    }
}

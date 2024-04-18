//
//  Game.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation

struct Game {
    let id: UUID
    let startDate: Date
    let endDate: Date
    let winner: String?
}
extension Game {
    var toSD: SDGame {
        SDGame(id: id, startDate: startDate, endDate: endDate, winner: winner)
    }
}

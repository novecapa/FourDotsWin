//
//  Play.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 17/4/24.
//

import Foundation

struct Play {

    let player: Player
    let index: Int

    var image: String {
        player == .human ? "basketball" : "soccerball"
    }
}

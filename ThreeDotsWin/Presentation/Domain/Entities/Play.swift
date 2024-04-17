//
//  Play.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 17/4/24.
//

import Foundation

struct Play {

    enum Player {
        case human
        case iphone
    }
    
    let player: Player
    let index: Int

    var image: String {
        player == .human ? "basketball" : "soccerball"
    }
}

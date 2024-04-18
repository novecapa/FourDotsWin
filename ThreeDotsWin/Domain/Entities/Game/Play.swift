//
//  Play.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 17/4/24.
//

import Foundation
import SwiftUI

struct Play {

    let player: Player
    let index: Int

    var color: Color {
        player == .human ? .yellow : .red
    }
}

//
//  GameViewBuilder.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 17/4/24.
//

import Foundation
import SwiftUI

final class GameViewBuilder {
    func build(viewModel: GameViewModel?) -> GameView {
        let view = GameView(viewModel: viewModel ?? GameViewModel())
        return view
    }
}

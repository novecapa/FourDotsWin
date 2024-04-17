//
//  MainViewModel.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 17/4/24.
//

import Foundation
import SwiftUI

final class MainViewModel: ObservableObject {

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())]

    func isSquareOccupied(plays: [Play?], index: Int) -> Bool {
        plays.contains(where: { $0?.index == index })
    }

    func determinateComputerPosition(plays: [Play?]) -> Int {
        var playPosition = Int.random(in: 0..<9)

        while isSquareOccupied(plays: plays, index: playPosition) {
            playPosition = Int.random(in: 0..<9)
        }

        return playPosition
    }
}

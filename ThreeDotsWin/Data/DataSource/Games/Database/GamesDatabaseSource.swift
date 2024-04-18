//
//  GamesDatabaseSource.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation
import SwiftData

final class GamesDatabaseSource: GamesDatabaseSourceProtocol {

    @MainActor
    var modelContainer: ModelContainer {
        SwiftDataContainer.modelContainer
    }

    @MainActor
    func gamesList() throws -> [SDGame] {
        let fetchDescriptor = FetchDescriptor<SDGame>(predicate: nil,
                                                      sortBy: [SortDescriptor<SDGame>(\.startDate)])
        return try modelContainer.mainContext.fetch(fetchDescriptor)
    }

    func saveGame(game: Game) {
        Task { @MainActor in
            modelContainer.mainContext.insert(game.toSD)
        }
    }
}

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

    /*
     let calendar = Calendar.current
     // Calcula las diferencias entre las dos fechas
     let diferencia = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: endDate)
     // Accede a las componentes de la diferencia
     if let horas = diferencia.hour, let minutos = diferencia.minute, let segundos = diferencia.second {
     */
    @MainActor
    func gamesList() throws -> [SDGame] {
        let fetchDescriptor = FetchDescriptor<SDGame>(predicate: #Predicate {
            $0.endGame == true
        }, sortBy: [SortDescriptor<SDGame>(\.startDate, order: .reverse)])
        return try modelContainer.mainContext.fetch(fetchDescriptor)
    }

    func saveGame(game: Game) {
        Task { @MainActor in
            modelContainer.mainContext.insert(game.toSD)
        }
    }
}

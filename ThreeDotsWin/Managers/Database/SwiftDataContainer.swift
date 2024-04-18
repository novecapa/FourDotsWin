//
//  SwiftDataContainer.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation
import SwiftData

@MainActor
final class SwiftDataContainer {
    static let modelContainer: ModelContainer = {
        do {
            let container = try ModelContainer(for: SDGame.self)
            return container
        } catch {
            fatalError("Failed to create model container for previewing: \(error.localizedDescription)")
        }
    }()
}

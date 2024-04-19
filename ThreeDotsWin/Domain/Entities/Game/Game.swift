//
//  Game.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation
import SwiftUI

struct Game {

    enum Constants {
        static let dateFormat = "dd/MM/YYYY HH:mm"
    }

    let id: UUID
    let startDate: Date
    var endDate: Date
    var winner: String?
    var endGame: Bool
}
extension Game {
    var toSD: SDGame {
        SDGame(id: id,
               startDate: startDate,
               endDate: endDate,
               winner: winner,
               endGame: endGame)
    }

    var dateStartString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        return dateFormatter.string(from: startDate)
    }

    var dateEndString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        return dateFormatter.string(from: endDate)
    }

    var gameDuration: String {
        // Strings
        let duration = "Game duration".localized()
        let hours = "hours".localized()
        let minutes = "minutes".localized()
        let seconds = "seconds".localized()
        let and = "and".localized()
        // Date values
        let calendar = Calendar.current
        let difference = calendar.dateComponents([.hour, .minute, .second],
                                                 from: startDate, to: endDate)
        if let hrs = difference.hour,
           let min = difference.minute,
           let sec = difference.second {
            if hrs > 0 {
                return """
                \(duration.localized()):
                 \(hours.localized()) \(hrs),
                 \(min) \(minutes.localized())
                 \(and.localized())
                 \(sec) \(seconds.localized()).
                """.removeEnters
            } else if min > 0 {
                return """
                \(duration.localized()):
                 \(min) \(minutes.localized())
                 \(and.localized())
                 \(sec) \(seconds.localized()).
                """.removeEnters
            } else {
                return """
                \(duration.localized()):
                 \(sec) \(seconds.localized()).
                """.removeEnters
            }
        } else {
            return ""
        }
    }

    var winnerName: Player? {
        switch winner {
        case "human":
            .human
        case "machine":
            .machine
        default:
            .human
        }
    }

    var winnerInitial: String {
        if let initial = (winnerName?.rawValue ?? "" ).first {
            return initial.uppercased()
        } else {
            return ""
        }
    }

    var colorWinner: Color {
        winnerName == .human ? .yellowPin : .redPin
    }
}

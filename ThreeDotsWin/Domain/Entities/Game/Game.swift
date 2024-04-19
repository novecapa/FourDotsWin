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
        SDGame(id: id, startDate: startDate, endDate: endDate, winner: winner, endGame: endGame)
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
        let calendar = Calendar.current
        let diferencia = calendar.dateComponents([.hour, .minute, .second], from: startDate, to: endDate)
        if let horas = diferencia.hour, let minutos = diferencia.minute, let segundos = diferencia.second {
            if horas > 0 {
                return "Duración: \(horas) horas, \(minutos) minutos y \(segundos) segundos."
            } else if minutos > 0 {
                return "Duración: \(minutos) minutos y \(segundos) segundos."
            } else {
                return "Duración: \(segundos) segundos."
            }
        } else {
            return "Duración: n"
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
        winnerName == .human ? .yellow : .red
    }
}

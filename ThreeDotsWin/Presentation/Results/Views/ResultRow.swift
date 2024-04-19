//
//  ResultRow.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 19/4/24.
//

import SwiftUI

struct ResultRow: View {

    let game: Game

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ZStack {
                    Circle()
                        .foregroundColor(game.colorWinner)
                        .frame(width: 40,
                               height: 40)
                    Text(game.winnerInitial)
                        .foregroundColor(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.leading)
                VStack(alignment: .leading, content: {
                    Text(game.dateStartString)
                        .foregroundColor(.black)
                    Text(game.gameDuration)
                        .foregroundColor(.black)
                })
                .padding()
                Spacer()
            }
            Rectangle()
                .fill(.blue)
                .frame(height: 4)
                .padding(.vertical, 1)
        }
        .background(Color.gray.opacity(0.2))
        .cornerRadius(6)
        .padding(.horizontal)
    }
}

#Preview {
    ResultRow(game: Game(id: UUID(), startDate: Date(), endDate: Date() + 300, winner: "machine", endGame: true))
}

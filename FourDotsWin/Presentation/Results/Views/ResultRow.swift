//
//  ResultRow.swift
//  FourDotsWin
//
//  Created by Josep Cerdá Penadés on 19/4/24.
//

import SwiftUI

struct ResultRow: View {

    enum Constants {
        static let cellColor: Color = Color.gray.opacity(0.2)
        static let textColor: Color = .textPin
        static let lineColor: Color = .bluePin
        static let cornerRadius: CGFloat = 6
        static let lineHeight: CGFloat = 4
    }

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
                        .foregroundColor(Constants.textColor)
                    Text(game.gameDuration)
                        .foregroundColor(Constants.textColor)
                })
                .padding()
                Spacer()
            }
            Rectangle()
                .fill(Constants.lineColor)
                .frame(height: Constants.lineHeight)
                .padding(.vertical, 1)
        }
        .background(Constants.cellColor)
        .cornerRadius(Constants.cornerRadius)
        .padding(.horizontal)
    }
}

#Preview {
    ResultRow(game: Game(id: UUID(), startDate: Date(), endDate: Date() + 300, winner: "machine", endGame: true))
}

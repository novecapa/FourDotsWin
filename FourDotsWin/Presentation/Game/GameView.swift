//
//  GameView.swift
//  FourDotsWin
//
//  Created by Josep Cerdá Penadés on 17/4/24.
//

import SwiftUI

struct GameView: View {

    enum Constants {
        static let spacing: CGFloat = 6
        static let playgroundPadding: CGFloat = 20
        static let cornerRadius: CGFloat = 12
        static let textColor: Color = .textPin
        static let gamePanelColor: Color = .bluePin
        static let backgroundColor: Color = .backgroundPin
    }

    @StateObject var viewModel: GameViewModel

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Game".localized())
                    .font(.title)
                    .foregroundColor(Constants.textColor)
                Spacer()
                ZStack {
                    LazyVGrid(columns: viewModel.gridItems, spacing: Constants.spacing) {
                        ForEach(0..<viewModel.totalPositions, id: \.self) { position in
                            ItemView(sizeWitdh: geometry.size.width,
                                     circleColor: viewModel.plays[position]?.color,
                                     columnsCount: viewModel.columns)
                            .onTapGesture {
                                viewModel.checkPlay(item: position)
                            }
                        }
                    }
                    .padding(Constants.playgroundPadding)
                }
                .background(Constants.gamePanelColor)
                .cornerRadius(Constants.cornerRadius)
                Spacer()
                Button("Restart Game".localized()) {
                    viewModel.resetGame()
                }
                .padding(.bottom)
                .font(.title3)
                .foregroundColor(Constants.gamePanelColor)
            }
            .disabled(viewModel.isBoardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem) {
                Alert(title: $0.title,
                      message: $0.message,
                      dismissButton: .default($0.buttonTitle,
                                              action: { viewModel.resetGame() }))
            }
            .background(Constants.backgroundColor)
        }
        .onAppear {
            viewModel.startGame()
        }
    }
}

#Preview {
    GameView(viewModel: GameViewModel())
}

//
//  GameView.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 17/4/24.
//

import SwiftUI

struct GameView: View {

    enum Constants {
        static let spacing: CGFloat = 6
    }

    @StateObject var viewModel: GameViewModel

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    Text("Play the game".localized())
                        .font(.title)
                    Spacer()
                    LazyVGrid(columns: viewModel.gridItems, spacing: Constants.spacing) {
                        ForEach(0..<viewModel.totalPositions, id: \.self) { position in
                            ItemView(sizeWitdh: geometry.size.width,
                                     imageName: viewModel.plays[position]?.image,
                                     columnsCount: viewModel.columns)
                            .onTapGesture {
                                viewModel.checkPlay(item: position)
                            }
                        }
                    }
                    Spacer()
                    Button("Restart Game".localized()) {
                        viewModel.resetGame()
                    }
                }
                .disabled(viewModel.isBoardDisabled)
                .padding()
                .alert(item: $viewModel.alertItem) {
                    Alert(title: $0.title,
                          message: $0.message,
                          dismissButton: .default($0.buttonTitle,
                                                  action: { viewModel.resetGame() }))
                }
            }
        }
    }
}

#Preview {
    GameView(viewModel: GameViewModel())
}

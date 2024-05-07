//
//  ResultsHistoryView.swift
//  FourDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import SwiftUI

struct ResultsHistoryView: View {

    enum Constants {
        static let textColor: Color = .textPin
        static let backgroundColor: Color = .backgroundPin
    }

    @State var viewModel: ResultsHistoryViewModel

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Results".localized())
                    .font(.title)
                    .foregroundColor(Constants.textColor)
            }
            ScrollView {
                VStack {
                    ForEach(viewModel.games, id: \.id) { game in
                        ResultRow(game: game)
                    }
                }
                .onAppear {
                    viewModel.getResultHistory()
                }
            }
            Spacer()
        }
        .background(Constants.backgroundColor)
    }
}

#Preview {
    ResultsHistoryView(viewModel: ResultsHistoryViewModel(useCase: GameUseCase(repository: GamesRepository(databaseSource: GamesDatabaseSource()))))
}

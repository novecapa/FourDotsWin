//
//  ResultsHistoryView.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import SwiftUI

struct ResultsHistoryView: View {

    @StateObject var viewModel: ResultsHistoryViewModel

    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.games, id: \.id) { game in
                    Text(game.winner ?? "")
                    Text(game.startDate.ISO8601Format())
                }
            }.onAppear {
                viewModel.getResultHistory()
            }
        }
    }
}

#Preview {
    ResultsHistoryView(viewModel: ResultsHistoryViewModel())
}

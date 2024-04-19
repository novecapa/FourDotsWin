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
        VStack {
            Spacer()
            Text("Results".localized())
                .font(.title)
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
    }
}

#Preview {
    ResultsHistoryView(viewModel: ResultsHistoryViewModel())
}

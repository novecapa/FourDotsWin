//
//  MainView.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import SwiftUI

struct MainView: View {

    enum Constants {
        static let iconGame: String = "gamecontroller"
        static let iconResults: String = "list.bullet.circle"
        static let tintColor: Color = .bluePin
    }

    @StateObject private var gameViewModel = GameViewModel()
    @StateObject private var resultsViewModel = ResultsHistoryViewModel()

    var body: some View {
        NavigationStack {
            TabView {
                GameViewBuilder().build(viewModel: gameViewModel)
                    .tabItem {
                        Image(systemName: Constants.iconGame)
                        Text("Game".localized())
                    }
                ResultsHistoryViewBuilder().build(viewModel: resultsViewModel)
                    .tabItem {
                        Image(systemName: Constants.iconResults)
                        Text("Results".localized())
                    }
            }
            .tint(Constants.tintColor)
        }
    }
}

#Preview {
    MainView()
}

//
//  MainView.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import SwiftUI

enum Tab: String {
    case one
    case two
    case third
}

struct MainView: View {

    @StateObject private var gameViewModel = GameViewModel()
    @StateObject private var resultsViewModel = ResultsHistoryViewModel()

    var body: some View {
        NavigationStack {
            TabView {
                GameViewBuilder().build(viewModel: gameViewModel)
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("Game")
                    }
                ResultsHistoryView(viewModel: resultsViewModel)
                    .tabItem {
                        Image(systemName: "2.square.fill")
                        Text("Results")
                    }
            }
        }
    }
}

#Preview {
    MainView()
}

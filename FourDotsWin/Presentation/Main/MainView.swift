//
//  MainView.swift
//  FourDotsWin
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

    var body: some View {
        NavigationStack {
            TabView {
                GameViewBuilder().build()
                    .tabItem {
                        Image(systemName: Constants.iconGame)
                        Text("Game".localized())
                    }
                ResultsHistoryViewBuilder().build()
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

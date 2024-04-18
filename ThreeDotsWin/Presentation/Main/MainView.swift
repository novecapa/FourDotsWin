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

    var body: some View {
        NavigationStack {
            TabView {
                GameView()
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("Game")
                    }
                    .tag(0)
                Text("Second Tab")
                    .tabItem {
                        Image(systemName: "2.square.fill")
                        Text("List")
                    }
                    .tag(1)
                Text("Third Tab")
                    .tabItem {
                        Image(systemName: "3.square.fill")
                        Text("Third")
                    }
                    .tag(2)
            }
            .navigationTitle("fffffff")
            .navigationBarItems(trailing: Text("N"))
        }
    }
}

#Preview {
    MainView()
}

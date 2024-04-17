//
//  MainView.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 17/4/24.
//

import SwiftUI

struct MainView: View {

    @State var viewModel = MainViewModel()
    @State var plays: [Play?] = Array(repeating: nil, count: 9)
    @State var isHumaTurn: Bool = true

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                LazyVGrid(columns: viewModel.columns, spacing: 6) {
                    ForEach(0..<9) { dot in
                        ZStack {
                            Circle()
                                .foregroundColor(.blue)
                                .frame(width: geometry.size.width/3 - 18,
                                       height: geometry.size.width/3 - 18)
                            Image(systemName: plays[dot]?.image ?? "")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                        }
                        .onTapGesture {
                            guard !viewModel.isSquareOccupied(plays: plays, index: dot) else { return }
                            plays[dot] = Play(player: .human, index: dot)

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                let computerPosition = viewModel.determinateComputerPosition(plays: plays)
                                plays[computerPosition] = Play(player: .iphone, index: computerPosition)
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    MainView()
}

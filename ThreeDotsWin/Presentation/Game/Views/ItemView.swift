//
//  ItemView.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import SwiftUI

struct ItemView: View {

    enum Constants {
        static let padding: CGFloat = 4
    }

    let sizeWitdh: CGFloat
    let circleColor: Color?
    let columnsCount: CGFloat

    var body: some View {
        Circle()
            .foregroundColor(circleColor ?? .white)
            .frame(width: sizeFrame,
                   height: sizeFrame)
            .padding(Constants.padding)
    }

    var sizeFrame: CGFloat {
        sizeWitdh/columnsCount - Constants.padding * columnsCount
    }
}

#Preview {
    ItemView(sizeWitdh: 1024,
             circleColor: .yellow,
             columnsCount: 4)
}

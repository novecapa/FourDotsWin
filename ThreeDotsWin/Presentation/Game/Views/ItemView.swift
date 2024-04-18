//
//  ItemView.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import SwiftUI

struct ItemView: View {

    enum Constants {
        static let padding: CGFloat = 6
        static let imageFrame: CGFloat = 40
        static let circleColor: Color = .green
        static let imageColor: Color = .white
    }

    let sizeWitdh: CGFloat
    let imageName: String?
    let columnsCount: CGFloat

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(Constants.circleColor)
                .frame(width: sizeFrame,
                       height: sizeFrame)
            Image(systemName: imageName ?? "")
                .resizable()
                .frame(width: Constants.imageFrame,
                       height: Constants.imageFrame)
                .foregroundColor(Constants.imageColor)
        }
    }

    var sizeFrame: CGFloat {
        sizeWitdh/columnsCount - Constants.padding * columnsCount
    }
}

#Preview {
    ItemView(sizeWitdh: 512, imageName: "basketball", columnsCount: 3)
}

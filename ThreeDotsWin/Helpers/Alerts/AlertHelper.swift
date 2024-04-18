//
//  AlertHelper.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import SwiftUI

final class AlertHelper {

    let title: Text
    let message: Text
    let buttonTitle: Text

    init(title: String, message: String, buttonTitle: String) {
        self.title = Text(title)
        self.message = Text(message)
        self.buttonTitle = Text(buttonTitle)
    }

    var alertItem: AlertItem {
        AlertItem(title: title, message: message, buttonTitle: buttonTitle)
    }
}

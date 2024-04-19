//
//  CustomExtensions.swift
//  ThreeDotsWin
//
//  Created by Josep Cerdá Penadés on 18/4/24.
//

import Foundation

// MARK: String
extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }

    var removeEnters: String {
        self.replacingOccurrences(of: "\n", with: "")
    }
}

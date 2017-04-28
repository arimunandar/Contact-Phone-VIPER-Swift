//
//  Extensions.swift
//  Contacts
//
//  Created by Ari Munandar on 4/26/17.
//  Copyright © 2017 Ari Munandar. All rights reserved.
//

import UIKit

extension String {
    func capitalizingFirstLetter() -> String {
        let first = String(characters.prefix(1)).capitalized
        let other = String(characters.dropFirst())
        return first + other
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

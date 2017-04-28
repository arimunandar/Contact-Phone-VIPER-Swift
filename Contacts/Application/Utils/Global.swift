//
//  Global.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright © 2017 Ari Munandar. All rights reserved.
//

import UIKit
import Hue

class Icons {
    static let GENERAL_HOME: String = ""
    static let GENERAL_PROFILE: String = ""
    static let GENERAL_BACK: String = ""
    static let GENERAL_NEXT: String = ""
    static let GENERAL_SETTING: String = ""
    static let GENERAL_ADD: String = ""
    static let GENERAL_EDIT: String = ""
    static let GENERAL_DELETE: String = "Delete"
    static let GENERAL_BERGER: String = "Menu"
    static let GENERAL_CAMERA: String = "Camera"
    static let GENERAL_MINUS: String = ""
    static let GENERAL_PLUS: String = ""
    static let GENERAL_SEARCH: String = "Search"
    static let GENERAL_WARNING: String = ""
    static let GENERAL_CART: String = "Shopping Cart"
    static let GENERAL_LIKE: String = "Like Filled"
    static let GENERAL_LIKE_EMPTY: String = "Like"
    static let GENERAL_NO_IMAGE: String = "no-profile-image"
    static let GENERAL_STAR: String = "Star"
}

class FontSize {
    static let SMALL: CGFloat = 10.0
    static let NORMAL: CGFloat = 12.0
    static let MEDIUM: CGFloat = 14.0
    static let LARGE: CGFloat = 16.0
    static let EXTRA_LARGE: CGFloat = 18.0
    static let DOUBLE_EXTRA_LARGE: CGFloat = 20.0
}

class Sizes {
    static let _5: CGFloat = 5.0
    static let _10: CGFloat = 10.0
    static let _15: CGFloat = 15.0
    static let _20: CGFloat = 20.0
    static let _25: CGFloat = 25.0
    static let _30: CGFloat = 30.0
    static let _35: CGFloat = 35.0
    static let _40: CGFloat = 40.0
    static let _50: CGFloat = 50.0
    static let _60: CGFloat = 60.0
    static let _70: CGFloat = 70.0
    static let _80: CGFloat = 80.0
    static let _90: CGFloat = 90.0
    static let _100: CGFloat = 100.0
    static let _150: CGFloat = 150.0
    static let _200: CGFloat = 200.0
    static let _300: CGFloat = 300.0

    static let BOUNDS = UIScreen.main.bounds
    static let HEIGTH = UIScreen.main.bounds.height
    static let WIDTH = UIScreen.main.bounds.width
    static let CORNER_RADIUS: CGFloat = 5
}

class Padding {
    static let _5: CGFloat = 5.0
    static let _8: CGFloat = 8.0
    static let _12: CGFloat = 12.0
    static let _16: CGFloat = 16.0
    static let _24: CGFloat = 24.0
    static let _32: CGFloat = 32.0
    static let _36: CGFloat = 36.0
}

class Colors {
    static let BLACK = UIColor(hex: "#000000")
    static let DARK_GREY = UIColor(hex: "#4A4A4A")
    static let MID_GREY = UIColor(hex: "#808080")
    static let LIGHT_GREY = UIColor(hex: "#E8E8E8")
    static let WHITE = UIColor(hex: "#FFFFFF")
    static let CLEAR = UIColor.clear
    static let GREEN = UIColor(hex: "#50E3C2")
    static let LIGHT_GREEN = UIColor(hex: "#A7F1E0")
    static let YELLOW = UIColor(hex: "#ffff00")
    static let SEPARATOR = UIColor(hex: "#F0F0F0")
    static let LIGHT_GREY_2 = UIColor(hex: "#FAFAFA")
}

class CacheKey {
    static let IS_SYNCRONIZE: String = "IsSyncronize"
}

class Route {
    // MARK: -Base Url
    static let baseUrl: String = "http://gojek-contacts-app.herokuapp.com"

    // MARK: -Contact API
    static let getContactList: String = "\(baseUrl)/contacts.json"
    static let getContactDetail: String = "\(baseUrl)/contacts/"
    static let putContact: String = "\(baseUrl)/contacts/"
    static let postContact: String = "\(baseUrl)/contacts.json"
    static let deleteContact: String = "\(baseUrl)/contacts/"
}

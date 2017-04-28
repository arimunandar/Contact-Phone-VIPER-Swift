//
//  IndicatorProgress.swift
//  Contacts
//
//  Created by Ari Munandar on 4/27/17.
//  Copyright © 2017 Ari Munandar. All rights reserved.
//

import UIKit
import EasyPeasy
import NVActivityIndicatorView

class DevcastAlert: NSObject {

    // MARK: Singleton
    class var sharedInstance: DevcastAlert {
        struct Singleton {
            static let instance: DevcastAlert = DevcastAlert()
        }
        return Singleton.instance
    }

    // MARK - Initial view
    var transparantView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        view.alpha = 0
        return view
    }()

    // MARK - Initial spiner
    let loadingSpinner: UIView = {
        let view = UIView()
        let spinner = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        spinner.color = Colors.WHITE
        spinner.type = .lineScalePulseOut
        spinner.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(spinner)
        view.alpha = 0
        return view
    }()

    // MARK - Initial completion
    var completion: (() -> Void)?

    // MARK - Set Properties Transparant View
    var heightTransparantView: CGFloat = 64
    var transparantViewBackground: UIColor = UIColor.darkGray

    // MARK - Initial function for loading
    func showLoading(isLoading: Bool) {

        // MARK - Set Loading
        if isLoading {
            self.loadingShow()
        } else {
            self.handleDismiss()
        }

    }

    override init() {
        super.init()

    }

}

// MARK - Setup Loading
extension DevcastAlert {

    // MARK - Setup View
    func loadingView(window: UIWindow) {

        // MARK - Initial message
        transparantView.backgroundColor = UIColor(white: 0, alpha: 0.7)

        // MARK - Initial adding subview
        window.addSubview(transparantView)
        window.addSubview(loadingSpinner)

    }

    // MARK - Initial Frames
    func loadingFrame() {

        transparantView <- [
            Top(),
            Left(),
            Right(),
            Bottom()
        ]

        loadingSpinner <- [
            CenterX(),
            CenterY(),
            Size(50)
        ]

    }

    // MARK - Setup Show Snackbar
    internal func loadingShow() {

        if let window = UIApplication.shared.keyWindow {

            // MARK - Initial view
            self.loadingView(window: window)

            // MARK - Initial frame
            self.loadingFrame()

            // MARK - Initial animation view
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

                self.transparantView.alpha = 1
                self.loadingSpinner.alpha = 1

                }, completion: nil)
        }

    }

}

// MARK - Setup handler
extension DevcastAlert {

    // MARK - Initial function for close action
    func handleAction() {

        if self.completion != nil {
            self.completion!()
        }
        self.handleDismiss()

    }

    // MARK - Initial function for hide snackbar
    func handleDismiss() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            self.transparantView.alpha = 0
            self.loadingSpinner.alpha = 0

        }) { (completed: Bool) in

            self.transparantView.removeFromSuperview()
            self.loadingSpinner.removeFromSuperview()

        }
    }

}

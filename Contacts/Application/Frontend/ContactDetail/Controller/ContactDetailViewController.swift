//
//  ContactDetailViewController.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

/**
* Setup ContactDetail ViewController
*/
class ContactDetailViewController: UIViewController {

    // MARK: - Setup Variables
    var presenterContactInput: ContactPresenterInputProtocol!
    var viewComponent: ContactDetailViewComponent!
    var request = ContactModel.Detail.Request()
    var isFavorite: Bool = false

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // MARK: - Handle Get Detail Data
        DevcastAlert.sharedInstance.showLoading(isLoading: true)
        self.presenterContactInput.setProcessContactDetail(request)

    }

    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Setup ContactDetailViewController Dependencies
        ContactDetailDependencies.sharedInstance.configure(viewController: self)

        // MARK: - Setup ContactDetailViewComponent
        self.setupComponent()

        // MARK: - Setup Notification
        NotificationCenter.default.addObserver(self, selector: #selector(handleFavorite), name: NSNotification.Name(rawValue: "Favorite"), object: nil)

    }

}

/**
* Setup ContactDetail View Controller
*/
extension ContactDetailViewController {

    // MARK - Initial function for Setup ContactDetail View Component
    internal func setupComponent() {

        self.viewComponent.setupComponent()

    }

}

/**
* Setup ContactDetail View Controller
*/
extension ContactDetailViewController {
    func handleFavorite(_ notification: NSNotification) {
        if let id = notification.userInfo?["id"] as? Int {
            var fav: Bool = false
            if self.isFavorite {
                fav = false
                self.isFavorite = false
                self.presenterContactInput.setProcessContactFavorite(ContactModel.Favorite.Request(id: id, isFavorite: fav))
            } else {
                fav = true
                self.isFavorite = true
                self.presenterContactInput.setProcessContactFavorite(ContactModel.Favorite.Request(id: id, isFavorite: fav))
            }
        }
    }

    func handleShowEditContact(id: Int?, contact: ContactListEntity?) {
        self.presenterContactInput.setProcessContactCreateOrUpdateShowFromDetail(id, contact: contact)
    }
}

/**
* Setup ContactDetail View Controller
*/
extension ContactDetailViewController: ContactDetailPresenterOutputProtocol {
    func displaySuccessContactDetail(_ response: ContactModel.Detail.Response) {
        guard let favorite = response.contact?.favorite else {
            return
        }
        self.isFavorite = favorite
        self.viewComponent.contact = response.contact
        self.viewComponent.contactDetailTable.reloadData()
        DevcastAlert.sharedInstance.showLoading(isLoading: false)
    }

    func displayErrorContactDetail(_ message: String) {
        print(message)
        DevcastAlert.sharedInstance.showLoading(isLoading: false)
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "Error", style: .cancel, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

/**
* Setup ContactDetail View Controller
*/
extension ContactDetailViewController: ContactFavoritePresenterOutputProtocol {
    func displaySuccessContactFavorite(_ response: ContactModel.Favorite.Response) {
        self.viewComponent.contact = response.contact
        self.viewComponent.contactDetailTable.reloadData()
    }

    func displayErrorContactFavorite(_ message: String) {
        print(message)
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "Error", style: .cancel, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}


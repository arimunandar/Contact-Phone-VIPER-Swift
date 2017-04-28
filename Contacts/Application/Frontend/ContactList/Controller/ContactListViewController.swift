//
//  ContactListViewController.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit
import Moya
import RealmSwift

/**
* Setup ContactList ViewController
*/
class ContactListViewController: UIViewController {

    // MARK: - Setup Variables
    var presenterContactInput: ContactPresenterInputProtocol!
    var viewComponent: ContactListViewComponent!
    var notificationToken: NotificationToken? = nil

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // MARK: - Sample Call Set Process
        if CacheHelper.getCacheBool(key: CacheKey.IS_SYNCRONIZE) {
            self.handleProcess()
        } else {
            self.handleProcess(isLoad: true)
        }

    }

    // MARK: - Object lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: - Setup ContactListViewController Dependencies
        ContactListDependencies.sharedInstance.configure(viewController: self)

        // MARK: - Setup ContactListViewComponent
        self.setupComponent()

        // MARK: - Show Loading
        DevcastAlert.sharedInstance.showLoading(isLoading: true)

    }

}

/**
* Setup ContactList View Controller
*/
extension ContactListViewController {

    // MARK - Initial function for Setup ContactList View Component
    internal func setupComponent() {

        self.viewComponent.setupComponent()

    }

}

/**
* Setup ContactList View Controller
*/
extension ContactListViewController: ContactListPresenterOutputProtocol {
    func displaySuccessContactList(_ response: ContactModel.List.Response) {

        guard let data = response.contacts else {
            return
        }
        self.viewComponent?.contactList = []
        self.viewComponent?.contactList = data
        self.viewComponent.statusLabel.isHidden = true
        self.viewComponent.contactListTable.isHidden = false
        self.viewComponent.alfabetLabel.isHidden = false
        self.viewComponent.contactListTable.reloadData()
        if (self.viewComponent?.refreshControl.isRefreshing)! {
            self.viewComponent?.refreshControl.endRefreshing()
        }

        DevcastAlert.sharedInstance.showLoading(isLoading: false)
    }

    func displayErrorContactList(_ message: String) {
        print(message)
        self.viewComponent.statusLabel.text = message
        let alertController = UIAlertController(title: "Message", message: message, preferredStyle: .alert)

        let OKAction = UIAlertAction(title: "Error", style: .cancel, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }

}

/**
* Setup ContactList View Controller
*/
extension ContactListViewController {
    func handleProcess(isLoad: Bool = false) {
        self.presenterContactInput.setProcessContactList(ContactModel.List.Request(isLoadData: isLoad))
    }

    func handleShowCreateContactPage() {
        self.presenterContactInput.setProcessContactCreateOrUpdateShowFromList()
    }

    func handleShowDetailContact(id: Int? = 0) {
        self.presenterContactInput.setProcessContactDetailShow(id)
    }
}

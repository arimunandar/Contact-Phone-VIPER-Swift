//
//  ContactListDependency.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

/**
* Setup ContactList Dependencies
*/
class ContactListDependencies {

    // MARK: Singleton
    class var sharedInstance: ContactListDependencies {
        struct Singleton {
            static let instance: ContactListDependencies = ContactListDependencies()
        }
        return Singleton.instance
    }

    // MARK: - Variables
    private(set) lazy var presenter: ContactPresenter = {
        return ContactPresenter()
    }()

    private(set) lazy var interactor: ContactInteractor = {
        return ContactInteractor()
    }()

    private(set) lazy var router: ContactRouter = {
        return ContactRouter()
    }()

    private(set) lazy var viewComponent: ContactListViewComponent = {
        return ContactListViewComponent()
    }()

    // MARK: - Configuration
    func configure(viewController: ContactListViewController) {

        self.presenter.interactorInput = self.interactor
        self.router.listContactViewController = viewController
        self.presenter.router = self.router
        self.presenter.presenterOutputList = viewController
        self.interactor.interactorOutputList = self.presenter

        self.viewComponent.viewController = viewController

        viewController.viewComponent = self.viewComponent
        viewController.presenterContactInput = self.presenter
        viewController.view.backgroundColor = UIColor.white
        viewController.navigationController?.navigationBar.isTranslucent = false
        viewController.navigationController?.navigationBar.clipsToBounds = false
        viewController.navigationController?.navigationBar.tintColor = Colors.GREEN
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()

    }

}

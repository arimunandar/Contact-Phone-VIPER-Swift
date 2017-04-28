//
//  ContactCreateOrUpdateDependency.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

/**
* Setup ContactCreateOrUpdate Dependencies
*/
class ContactCreateOrUpdateDependencies {

    // MARK: Singleton
    class var sharedInstance: ContactCreateOrUpdateDependencies {
        struct Singleton {
            static let instance: ContactCreateOrUpdateDependencies = ContactCreateOrUpdateDependencies()
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

    private(set) lazy var viewComponent: ContactCreateOrUpdateViewComponent = {
        return ContactCreateOrUpdateViewComponent()
    }()

    // MARK: - Configuration
    func configure(viewController: ContactCreateOrUpdateViewController) {

        self.presenter.interactorInput = self.interactor
        self.router.createOrUpdateContactViewController = viewController
        self.presenter.router = self.router
        self.presenter.presenterOutputCreate = viewController
        self.presenter.presenterOutputUpdate = viewController
        self.interactor.interactorOutputCreate = self.presenter
        self.interactor.interactorOutputUpdate = self.presenter

        self.viewComponent.viewController = viewController

        viewController.viewComponent = viewComponent
        viewController.presenterContactInput = self.presenter
        viewController.view.backgroundColor = UIColor.white
        viewController.navigationController?.navigationBar.isTranslucent = false
        viewController.navigationController?.navigationBar.clipsToBounds = false
        viewController.navigationController?.navigationBar.tintColor = Colors.GREEN
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()

    }

}

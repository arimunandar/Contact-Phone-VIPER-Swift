//
//  ContactDetailDependency.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

/**
* Setup ContactDetail Dependencies
*/
class ContactDetailDependencies {

    // MARK: Singleton
    class var sharedInstance: ContactDetailDependencies {
        struct Singleton {
            static let instance: ContactDetailDependencies = ContactDetailDependencies()
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

    private(set) lazy var viewComponent: ContactDetailViewComponent = {
        return ContactDetailViewComponent()
    }()

    // MARK: - Configuration
    func configure(viewController: ContactDetailViewController) {

        self.presenter.interactorInput = self.interactor
        self.router.detailContactViewController = viewController
        self.presenter.router = self.router
        self.presenter.presenterOutputDetail = viewController
        self.presenter.presenterOutputFavorite = viewController
        self.interactor.interactorOutputDetail = self.presenter
        self.interactor.interactorOutputFavorite = self.presenter

        self.viewComponent.viewController = viewController
        viewController.presenterContactInput = self.presenter
        viewController.viewComponent = viewComponent
        viewController.view.backgroundColor = UIColor.white
        viewController.navigationController?.navigationBar.isTranslucent = false
        viewController.navigationController?.navigationBar.clipsToBounds = false
        viewController.navigationController?.navigationBar.tintColor = Colors.GREEN
        viewController.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        viewController.navigationController?.navigationBar.shadowImage = UIImage()

    }

}

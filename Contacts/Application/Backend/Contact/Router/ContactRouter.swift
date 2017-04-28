//
//  ContactRouter.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

/**
* Setup Contact Router with Contact Router Protocol
*/
class ContactRouter: ContactRouterProtocol {

    // MARK: - Setup View Controller
    weak var createOrUpdateContactViewController: ContactCreateOrUpdateViewController?
    weak var detailContactViewController: ContactDetailViewController?
    weak var listContactViewController: ContactListViewController?

    func handleDismissCreateOrUpdatePage() {
        self.createOrUpdateContactViewController?.dismiss(animated: true, completion: nil)
    }

    func handleShowDetailPage(_ id: Int? = 0) {
        let vc = ContactDetailViewController()
        vc.request = ContactModel.Detail.Request(id: id)
        self.listContactViewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func handleShowCreateOrUpdatePageFromListPage() {
        let vc = ContactCreateOrUpdateViewController()
        vc.isCreate = true
        let nav = UINavigationController(rootViewController: vc)
        self.listContactViewController?.present(nav, animated: true, completion: nil)
    }

    func handleShowCreateOrUpdatePageFromDetailPage(_ id: Int? = 0, contact: ContactListEntity?) {
        let vc = ContactCreateOrUpdateViewController()
        vc.isCreate = false
        vc.idContact = id
        let nav = UINavigationController(rootViewController: vc)
        self.detailContactViewController?.present(nav, animated: true, completion: nil)
    }

}

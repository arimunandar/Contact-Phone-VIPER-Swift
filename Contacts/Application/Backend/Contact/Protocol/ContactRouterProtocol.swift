//
//  ContactRouterProtocol.swift
//  Contacts
//
//  Created by Ari Munandar on 4/21/17.
//  Copyright (c) 2017 Ari Munandar. All rights reserved.
//  Modify By:  * Ari Munandar
//              * arimunandar.dev@gmail.com
//              * https://github.com/arimunandar

import UIKit

/**
* Setup Contact Router Protocol
*/
protocol ContactRouterProtocol: class {

    // Function for handle dismiss page
    func handleDismissCreateOrUpdatePage()

    // Function for handle show page
    func handleShowCreateOrUpdatePageFromDetailPage(_ id: Int?, contact: ContactListEntity?)

    // Function for handle show page
    func handleShowCreateOrUpdatePageFromListPage()

    // Function for handle show page
    func handleShowDetailPage(_ id: Int?)
}

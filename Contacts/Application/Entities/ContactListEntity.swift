//
//  ContactListEntity.swift
//
//  Created by Ari Munandar on 4/23/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

public class ContactListEntity: Object, Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let profilePic = "profile_pic"
        static let lastName = "last_name"
        static let id = "id"
        static let favorite = "favorite"
        static let firstName = "first_name"
        static let url = "url"
        static let phoneNumber = "phone_number"
        static let email = "email"
    }

    // MARK: Properties
    public dynamic var profilePic: String?
    public dynamic var lastName: String?
    public dynamic var id: Int = 0
    public dynamic var favorite: Bool = false
    public dynamic var firstName: String?
    public dynamic var url: String?
    public dynamic var phoneNumber: String?
    public dynamic var email: String?

    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    required convenience public init?(map: Map) {
        self.init()
    }

    // MARK: Set Primary Key
    public override static func primaryKey() -> String? {
        return "id"
    }

    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public func mapping(map: Map) {
        profilePic <- map[SerializationKeys.profilePic]
        lastName <- map[SerializationKeys.lastName]
        id <- map[SerializationKeys.id]
        favorite <- map[SerializationKeys.favorite]
        firstName <- map[SerializationKeys.firstName]
        url <- map[SerializationKeys.url]
        phoneNumber <- map[SerializationKeys.phoneNumber]
        email <- map[SerializationKeys.email]
    }

}

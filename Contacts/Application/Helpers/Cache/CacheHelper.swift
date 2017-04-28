//
//  CacheHelper.swift
//  Contacts
//
//  Created by Ari Munandar on 4/25/17.
//  Copyright © 2017 Ari Munandar. All rights reserved.
//

import UIKit

class CacheHelper {

    /**
	Set Jabatan ID
	
	- parameter id: id description
	*/
    class func setCache(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    /**
	Get String Data
	
	- returns: String Data (String)
	*/
    class func getCacheString(key: String) -> String {
        guard let data = UserDefaults.standard.string(forKey: key) else {
            return ""
        }
        return data
    }

    /**
	Get String Data
	
	- returns: String Data (String)
	*/
    class func getCacheInt(key: String) -> Int {
        return UserDefaults.standard.integer(forKey: key)
    }

    /**
	Get Bool Data
	
	- returns: Bool Data (Bool)
	*/
    class func getCacheBool(key: String) -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }

}

//
//  BundleEx.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 25/11/24.
//

import Foundation

private var bundleKey: UInt8 = 0

private class CustomBundle: Bundle, @unchecked Sendable {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
            guard let path = Bundle.main.path(forResource: Bundle.currentLanguage, ofType: "lproj"),
                  let languageBundle = Bundle(path: path) else {
                return super.localizedString(forKey: key, value: value, table: tableName)
            }
            return languageBundle.localizedString(forKey: key, value: value, table: tableName)
        }
}

extension Bundle {
    private static var onLanguageDispatchOnce: Void = {
        object_setClass(Bundle.main, CustomBundle.self)
    }()
    
    static var currentLanguage: String = "en"
    
    static func setLanguage(_ language: String) {
        currentLanguage = language
        onLanguageDispatchOnce
    }
    
    class func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return Bundle.main.localizedString(forKey: key, value: value, table: tableName)
    }
}

//
//  BundleEx.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 25/11/24.
//

import Foundation

private var bundleKey: UInt8 = 0

final class BundleEx: Bundle, @unchecked Sendable {
    override func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        guard let languageBundle = objc_getAssociatedObject(self, &bundleKey) as? Bundle else {
            return super.localizedString(forKey: key, value: value, table: tableName)
        }
        return languageBundle.localizedString(forKey: key, value: value, table: tableName)
    }
}

extension Bundle {
    private static var bundle: Bundle?

    static func setLanguage(_ language: String) {
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"),
              let languageBundle = Bundle(path: path) else {
            self.bundle = nil
            return
        }
        objc_setAssociatedObject(Bundle.main, &bundleKey, languageBundle, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.bundle = languageBundle
    }

    class func localizedString(forKey key: String, value: String?, table tableName: String?) -> String {
        return bundle?.localizedString(forKey: key, value: value, table: tableName) ??
               NSLocalizedString(key, tableName: tableName, value: value ?? key, comment: "")
    }
}

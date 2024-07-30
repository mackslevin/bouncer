//
//  UserDefaults-Ext.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/30/24.
//

import Foundation

// So that we can store codable types in UserDefaults

//extension UserDefaults {
//    func set<T: Codable>(_ value: T, forKey key: String) {
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(value) {
//                self.set(encoded, forKey: key)
//            }
//        }
//
//        func codable<T: Codable>(forKey key: String) -> T? {
//            if let data = self.data(forKey: key) {
//                let decoder = JSONDecoder()
//                return try? decoder.decode(T.self, from: data)
//            }
//            return nil
//        }
//}

//
//  PhotoCredit.swift
//  TVBouncyBoy
//
//  Created by Mack Slevin on 7/31/24.
//

import Foundation
import Observation

@Observable
final class PhotoCredit: Identifiable {
    let id = UUID()
    let name: String
    let unsplashURL: URL
    let photographerImageURL: URL
    let imageNames: [String] // These match images names in the asset catalog
    
    init(name: String, unsplashURL: URL, photographerImageURL: URL, imageNames: [String]) {
        self.name = name
        self.unsplashURL = unsplashURL
        self.photographerImageURL = photographerImageURL
        self.imageNames = imageNames
    }
    
    static let credits: [PhotoCredit] = [
        PhotoCredit(name: "Joshua Sortino", unsplashURL: URL(string: "https://unsplash.com/@sortino")!, photographerImageURL: URL(string: "https://images.unsplash.com/profile-1597021546022-3520b8ec368aimage?bg=fff&crop=faces&dpr=2&h=150&w=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["mountains-trees"]),
        PhotoCredit(name: "Nigel Hoare", unsplashURL: URL(string: "https://unsplash.com/@dementedpixel")!, photographerImageURL: URL(string: "https://images.unsplash.com/profile-1680535924333-dd1d262b54a9image?bg=fff&crop=faces&dpr=2&h=150&w=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["mars"]),
        PhotoCredit(name: "Pawel Czerwinski", unsplashURL: URL(string: "https://unsplash.com/@pawel_czerwinski")!, photographerImageURL: URL(string: "https://images.unsplash.com/profile-1592328433409-d9ce8a5333eaimage?bg=fff&crop=faces&dpr=2&h=150&w=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["dark-purple-abstract"]),
        PhotoCredit(name: "Dan Carlson", unsplashURL: URL(string: "https://unsplash.com/@dan_carl5on")!, photographerImageURL: URL(string: "https://images.unsplash.com/profile-1445571144389-c57510c7248c?bg=fff&crop=faces&dpr=2&h=150&w=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["sky-flowers"]),
        PhotoCredit(name: "Manja Vitolic", unsplashURL: URL(string: "https://unsplash.com/@madhatterzone")!, photographerImageURL: URL(string: "https://images.unsplash.com/profile-fb-1514888261-0e72294039e0.jpg?bg=fff&crop=faces&dpr=2&h=150&w=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["cat"])
    ]
}

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
        PhotoCredit(name: "Pawel Czerwinski", unsplashURL: URL(string: "https://unsplash.com/@pawel_czerwinski")!, photographerImageURL: URL(string: "https://images.unsplash.com/profile-1592328433409-d9ce8a5333eaimage?bg=fff&crop=faces&dpr=2&h=150&w=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["dark-purple-abstract"]),
        PhotoCredit(name: "Manja Vitolic", unsplashURL: URL(string: "https://unsplash.com/@madhatterzone")!, photographerImageURL: URL(string: "https://images.unsplash.com/profile-fb-1514888261-0e72294039e0.jpg?bg=fff&crop=faces&dpr=2&h=150&w=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["cat"]),
        PhotoCredit(name: "Dan Carlson", unsplashURL: URL(string: "https://unsplash.com/@dan_carl5on")!, photographerImageURL: URL(string: "https://images.unsplash.com/profile-1445571144389-c57510c7248c?bg=fff&crop=faces&dpr=2&h=150&w=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["sky-flowers"]),
        PhotoCredit(name: "Nathan Anderson", unsplashURL: URL(string:"https://unsplash.com/@nathananderson")!, photographerImageURL: URL(string:"https://images.unsplash.com/profile-1676320214445-e3fec6f7b87cimage?w=150&dpr=2&crop=faces&bg=%23fff&h=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["space"]),
        PhotoCredit(name: "Vincent Erhart", unsplashURL: URL(string:"https://unsplash.com/@vince_erhart")!, photographerImageURL: URL(string:"https://images.unsplash.com/profile-fb-1484850152-20f453977689.jpg?w=150&dpr=2&crop=faces&bg=%23fff&h=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["coal-mine"]),
        PhotoCredit(name: "Yifu Wu", unsplashURL: URL(string:"https://unsplash.com/@nnonno")!, photographerImageURL: URL(string:"https://images.unsplash.com/profile-1663759784115-b289bd302e92image?w=150&dpr=2&crop=faces&bg=%23fff&h=150&auto=format&fit=crop&q=60&ixlib=rb-4.0.3")!, imageNames: ["veiny-road"])
        
    ]
}

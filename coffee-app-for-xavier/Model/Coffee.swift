//
//  Coffee.swift
//  coffee-app-for-xavier
//
//  Created by Krystal Zhang on 11/10/22.
//

import SwiftUI

//MARK: Coffee model with simple data
struct Coffee: Identifiable{
    var id: UUID = .init()
    var imageName: String
    var title: String
    var price: String
}

var coffees: [Coffee] = [
    .init(imageName:"Item 1", title: "Strawberry Frappucino\nCold Drink", price: "$3.99"),
    .init(imageName:"Item 2", title: "Iced Americano\nCoffee", price: "2.55"),
    .init(imageName:"Item 3", title: "Mocha Frappucino\nCold Drink", price: "4.55"),
    .init(imageName:"Item 4", title: "Java Chocolate Chips Frappucino\nCold Drink", price: "3.84"),
    .init(imageName:"Item 5", title: "Iced Vanilla Latte with Chocolate Chips\nlatte", price: "2.67"),
    .init(imageName:"Item 6", title: "Hot Espresso\nHot Coffee", price: "2.76"),
    .init(imageName:"Item 7", title: "Green Tea Frappucino\nCold Drink", price: "$5.76"),
    .init(imageName:"Item 8", title: "Iced Lemon Tea", price: "2.22"),
]

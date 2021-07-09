//
//  Information.swift
//  StackView
//
//  Created by Harbros47 on 17.02.21.
//

import Foundation
import UIKit

struct Phone {
    var name: String
    var price: Float
}

struct Shoping {
    
    static func createArrayPhone() -> [Phone] {
        let phone1 = Phone(name: "Mi", price: 599.9)
        let phone2 = Phone(name: "Sumsung", price: 499.9)
        let phone3 = Phone(name: "iPhone", price: 1000)
        let phone4 = Phone(name: "Huawei", price: 300)
        let phone5 = Phone(name: "Poco", price: 299.9)
        let phone6 = Phone(name: "iPhone", price: 799.9)
        let phone7 = Phone(name: "Sumsung", price: 699.9)
        let phone8 = Phone(name: "Mi", price: 1599.9)
        let phone9 = Phone(name: "iPhone", price: 1000.9)
        let phone10 = Phone(name: "Mi", price: 999.9)
        let phone11 = Phone(name: "Huawei", price: 599.9)
        let phone12 = Phone(name: "Huawei", price: 499.9)
        let phone13 = Phone(name: "Poco", price: 1000)
        let phone14 = Phone(name: "Sumsung", price: 300)
        let phone15 = Phone(name: "Mi", price: 299.9)
        let phone16 = Phone(name: "iPhone", price: 799.9)

        return [
            phone1,
            phone2,
            phone3,
            phone4,
            phone5,
            phone6,
            phone7,
            phone8,
            phone9,
            phone10,
            phone11,
            phone12,
            phone13,
            phone14,
            phone15,
            phone16
        ]
    }
 
    static func setup() -> [Phone] {
        
        let labelText = createArrayPhone().randomElement() ?? Phone(name: "", price: 0)
        let labelText1 = createArrayPhone().randomElement() ?? Phone(name: "", price: 0)
        let labelText2 = createArrayPhone().randomElement() ?? Phone(name: "", price: 0)
        let labelText3 = createArrayPhone().randomElement() ?? Phone(name: "", price: 0)
        
        let arrayLabel = [labelText, labelText1, labelText2, labelText3]
        
        return arrayLabel
    }
}

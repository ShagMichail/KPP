//
//  BuyManager.swift
//  KPP
//
//  Created by Михаил Шаговитов on 20.03.2022.
//

import Foundation
import UIKit

protocol BuyManagerProtocol {
    var output: BuyManagerOutput? { get set }
    
    func loadPhoto()
}

protocol BuyManagerOutput: AnyObject {
    func didReceive(_ cars: [Cars])
}

class BuyManager: BuyManagerProtocol {
    
    static let shared: BuyManagerProtocol = BuyManager()
    
    weak var output: BuyManagerOutput?
    
    private init() {}
    
    func loadPhoto() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let cars = [
                Cars(image: (UIImage(named: "chests") ?? #imageLiteral(resourceName: "house")), brand: "Mazda", model: "RX-7", horsepower: "150", year: "1995", fuel: "Бензин", countRegistration: 2, dtp: 1),
                Cars(image: (UIImage(named: "chest") ?? #imageLiteral(resourceName: "VK")), brand: "Honda", model: "Civic", horsepower: "110", year: "1998", fuel: "Бензин", countRegistration: 2, dtp: 1),
                Cars(image: (UIImage(named: "chests") ?? #imageLiteral(resourceName: "master")), brand: "Mersedes", model: "E class", horsepower: "184", year: "2017", fuel: "Бензин", countRegistration: 2, dtp: 1),
            ]
            
            self.output?.didReceive(cars)
        }
    }
}

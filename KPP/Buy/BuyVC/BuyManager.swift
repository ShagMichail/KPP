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
                Cars(image: (UIImage(named: "chests") ?? #imageLiteral(resourceName: "house")), name: "Mazda"),
                Cars(image: (UIImage(named: "chest") ?? #imageLiteral(resourceName: "VK")), name: "Honda"),
                Cars(image: (UIImage(named: "chests") ?? #imageLiteral(resourceName: "master")), name: "Mersedes"),
            ]
            
            self.output?.didReceive(cars)
        }
    }
}

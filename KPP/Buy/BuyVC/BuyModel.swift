//
//  BuyModel.swift
//  KPP
//
//  Created by Михаил Шаговитов on 20.03.2022.
//

import UIKit

protocol BuyDescription: AnyObject {
    var output: BuyInput? { get set }
    
    func loadPhoto()
}

final class BuyModel: BuyDescription {

    
    private var buyManager: BuyManagerProtocol = BuyManager.shared
    
    weak var output: BuyInput?
    
    func loadPhoto() {
        buyManager.loadPhoto()
        buyManager.output = self
    }
}

extension BuyModel: BuyManagerOutput {
    func didReceive(_ cars: [Cars]) {
        output?.didReceive(cars)
    }
}

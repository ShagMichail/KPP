//
//  HummanManager.swift
//  KPP
//
//  Created by Михаил Шаговитов on 09.03.2022.
//

import Foundation
import UIKit

protocol HumanManagerProtocol {
    var output: HumanManagerOutput? { get set }
    
    func loadHuman()
}

protocol HumanManagerOutput: AnyObject {
    func didReceive(_ human: [Human])
}

class HumanManager: HumanManagerProtocol {
    
    static let shared: HumanManagerProtocol = HumanManager()
    
    weak var output: HumanManagerOutput?
    
    private init() {}
    
    func loadHuman() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let human = [
                Human(image: (UIImage(named: "evgen") ?? #imageLiteral(resourceName: "maxresdefault-3.jpg")), link: "zheki444"),
                Human(image: (UIImage(named: "evgen") ?? #imageLiteral(resourceName: "VK")), link: "zheki444"),
                Human(image: (UIImage(named: "evgen") ?? #imageLiteral(resourceName: "VK")), link: "zheki444"),
            ]
            
            self.output?.didReceive(human)
        }
    }
}

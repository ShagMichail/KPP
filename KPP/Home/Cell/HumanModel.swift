//
//  HumanModel.swift
//  KPP
//
//  Created by Михаил Шаговитов on 09.03.2022.
//
import UIKit

protocol CollectionModelDescription: AnyObject {
    var output: CollectionViewControllerInput? { get set }
    
    func loadHuman()
}

final class HumanModel: CollectionModelDescription {

    
    private var humanManager: HumanManagerProtocol = HumanManager.shared
    
    weak var output: CollectionViewControllerInput?
    
    func loadHuman() {
        humanManager.loadHuman()
        humanManager.output = self
    }
}

extension HumanModel: HumanManagerOutput {
    func didReceive(_ human: [Human]) {
        output?.didReceive(human)
    }
}

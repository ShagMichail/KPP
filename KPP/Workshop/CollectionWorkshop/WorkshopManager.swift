//
//  WorkshopManager.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import Foundation
import UIKit

protocol WorkshopPhotoManagerProtocol {
    var output: WorkshopPhotoManagerOutput? { get set }
    
    func loadWorkshopPhoto()
}

protocol WorkshopPhotoManagerOutput: AnyObject {
    func didReceive(_ workshop: [WorkshopPhoto])
}

class WorkshopPhotoManager: WorkshopPhotoManagerProtocol {

    
    static let shared: WorkshopPhotoManagerProtocol = WorkshopPhotoManager()
    
    weak var output: WorkshopPhotoManagerOutput?
    
    private init() {}
    
    func loadWorkshopPhoto() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let workshop = [
                WorkshopPhoto(image: (UIImage(named: "house") ?? #imageLiteral(resourceName: "help"))),
                WorkshopPhoto(image: (UIImage(named: "house") ?? #imageLiteral(resourceName: "VK"))),
                WorkshopPhoto(image: (UIImage(named: "house") ?? #imageLiteral(resourceName: "VK"))),
            ]
            
            self.output?.didReceive(workshop)
        }
    }
}


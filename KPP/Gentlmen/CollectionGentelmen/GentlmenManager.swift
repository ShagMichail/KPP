//
//  PhotoManager.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import Foundation
import UIKit

protocol GentlmenPhotoManagerProtocol {
    var output: GentlmenPhotoManagerOutput? { get set }
    
    func loadGentlmenPhoto()
}

protocol GentlmenPhotoManagerOutput: AnyObject {
    func didReceive(_ gentlmen: [GentlmenPhoto])
}

class GentlmenPhotoManager: GentlmenPhotoManagerProtocol {

    
    static let shared: GentlmenPhotoManagerProtocol = GentlmenPhotoManager()
    
    weak var output: GentlmenPhotoManagerOutput?
    
    private init() {}
    
    func loadGentlmenPhoto() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let gentlmen = [
                GentlmenPhoto(image: (UIImage(named: "gentlmen") ?? #imageLiteral(resourceName: "help"))),
                GentlmenPhoto(image: (UIImage(named: "gentlmen") ?? #imageLiteral(resourceName: "VK"))),
                GentlmenPhoto(image: (UIImage(named: "gentlmen") ?? #imageLiteral(resourceName: "VK"))),
            ]
            
            self.output?.didReceive(gentlmen)
        }
    }
}

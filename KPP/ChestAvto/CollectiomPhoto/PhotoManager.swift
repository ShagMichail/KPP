//
//  PhotoManager.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import Foundation
import UIKit

protocol PhotoManagerProtocol {
    var output: PhotoManagerOutput? { get set }
    
    func loadPhoto()
}

protocol PhotoManagerOutput: AnyObject {
    func didReceive(_ photo: [Photo])
}

class PhotoManager: PhotoManagerProtocol {
    
    static let shared: PhotoManagerProtocol = PhotoManager()
    
    weak var output: PhotoManagerOutput?
    
    private init() {}
    
    func loadPhoto() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let photo = [
                Photo(image: (UIImage(named: "chest") ?? #imageLiteral(resourceName: "VK"))),
                Photo(image: (UIImage(named: "chest") ?? #imageLiteral(resourceName: "VK"))),
                Photo(image: (UIImage(named: "chest") ?? #imageLiteral(resourceName: "VK"))),
            ]
            
            self.output?.didReceive(photo)
        }
    }
}

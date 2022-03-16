//
//  PhotoModel.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import UIKit

protocol CollectionModelGentlmenPhotoDescription: AnyObject {
    var output: CollectionViewGentlmenInput? { get set }
    
    func loadGentlmenPhoto()
}

final class GentlmenModel: CollectionModelGentlmenPhotoDescription {

    
    private var photoGentlmenManager: GentlmenPhotoManagerProtocol = GentlmenPhotoManager.shared
    
    weak var output: CollectionViewGentlmenInput?
    
    func loadGentlmenPhoto() {
        photoGentlmenManager.loadGentlmenPhoto()
        photoGentlmenManager.output = self
    }
}

extension GentlmenModel: GentlmenPhotoManagerOutput {
    func didReceive(_ gentlmen: [GentlmenPhoto]) {
        output?.didReceive(gentlmen)
    }
}

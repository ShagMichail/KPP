//
//  PhotoModel.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import UIKit

protocol CollectionModelPhotoDescription: AnyObject {
    var output: CollectionViewChestInput? { get set }
    
    func loadPhoto()
}

final class PhotoModel: CollectionModelPhotoDescription {

    
    private var photoManager: PhotoManagerProtocol = PhotoManager.shared
    
    weak var output: CollectionViewChestInput?
    
    func loadPhoto() {
        photoManager.loadPhoto()
        photoManager.output = self
    }
}

extension PhotoModel: PhotoManagerOutput {
    func didReceive(_ photo: [Photo]) {
        output?.didReceive(photo)
    }
}

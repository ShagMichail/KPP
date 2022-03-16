//
//  WorkshopModel.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import UIKit

protocol CollectionModelWorkshopPhotoDescription: AnyObject {
    var output: CollectionViewWorkshopInput? { get set }
    
    func loadWorkshopPhoto()
}

final class WorkshopModel: CollectionModelWorkshopPhotoDescription {

    
    private var photoWorkshopManager: WorkshopPhotoManagerProtocol = WorkshopPhotoManager.shared
    
    weak var output: CollectionViewWorkshopInput?
    
    func loadWorkshopPhoto() {
        photoWorkshopManager.loadWorkshopPhoto()
        photoWorkshopManager.output = self
    }
}

extension WorkshopModel: WorkshopPhotoManagerOutput {
    func didReceive(_ workshop: [WorkshopPhoto]) {
        output?.didReceive(workshop)
    }
}

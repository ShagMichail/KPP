//
//  ContainerVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 24.02.2022.
//

import UIKit

class ContainerVC: UIViewController {

    enum MenuState{
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    private let menuVC = MenuVC()
    private let homeVC = HomeVC()
    lazy var infoVC = InfoVC()
    lazy var workshopVC = WorkshopVC()
    lazy var gentlmenVC = GentelmenVC()
    lazy var chestAvtoVC = ChestAvtoVC()
    private var navVC: UINavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC()
    }

    private func addChildVC(){
        
        //Menu
        menuVC.delegate = self
        addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        //Home
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
        
        chestAvtoVC.delegate = self
        
        gentlmenVC.delegate = self
        
        workshopVC.delegate = self
        
        infoVC.delegate = self
    }
}

extension ContainerVC: HomeVCDelegate, ChestAvtoVCDelegate, GentelmenVCDelegate, WorkshopVCDelegate, InfoVCDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .opened
                }
            }
                          
        case .opened:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                self.navVC?.view.frame.origin.x = 0
            } completion: { [weak self] done in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
}

extension ContainerVC: MenuVCDelegate {
    func didSelect(menuItem: MenuVC.MenuOptions) {
        toggleMenu (completion: nil)
            switch menuItem {
            case .home:
                self.resetToHome()
            case .chestAvto:
                self.addChestAvto()
            case .workshop:
                self.addWorkshop()
            case .gentlemen:
                self.addGentlmen()
            case .info:
                self.addInfo()
            }
        
    }
    
    func addInfo(){
        resetToHome()
        let vc = infoVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        homeVC.navigationItem.title = "Контактная информация"
        vc.view.tag = 10
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
    }
    
    func addWorkshop(){
        resetToHome()
        let vc = workshopVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        homeVC.navigationItem.title = "Мастерская синдиката"
        vc.view.tag = 20
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
    }
    
    func addGentlmen(){
        resetToHome()
        let vc = gentlmenVC
        homeVC.addChild(vc)
        homeVC.view.addSubview(vc.view)
        homeVC.navigationItem.title = "Джентельмены синдиката"
        vc.view.tag = 30
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
    }
    
    func addChestAvto(){
        resetToHome()
        let vc = chestAvtoVC
        homeVC.addChild(vc)
    
        homeVC.view.addSubview(vc.view)
        homeVC.navigationItem.title = "Chest Avto"
        vc.view.tag = 40
        vc.view.frame = view.frame
        vc.didMove(toParent: homeVC)
    }
    
    func resetToHome(){
        if (self.view.viewWithTag(10) != nil) {
            infoVC.view.removeFromSuperview()
            infoVC.didMove(toParent: nil)
        }
        if (self.view.viewWithTag(20) != nil) {
            workshopVC.view.removeFromSuperview()
            workshopVC.didMove(toParent: nil)
        }
        if (self.view.viewWithTag(30) != nil) {
            gentlmenVC.view.removeFromSuperview()
            gentlmenVC.didMove(toParent: nil)
        }
        
        if (self.view.viewWithTag(40) != nil) {
            chestAvtoVC.view.removeFromSuperview()
            chestAvtoVC.didMove(toParent: nil)
        }
        
        homeVC.setupNavBar()
    }
}

//
//  BuyVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import UIKit

class BuyVC: UIViewController {

    //guard let title = UIL
    
    var navBar: CustomNav = {
        let view = CustomNav()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddSubview()
        setupLayout()
        setupElement()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        
    }
    
    private func setupElement(){
        view.backgroundColor = .systemBackground
    }
    
    func setupNavBar(){
        navBar.navButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        navBar.navButton.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
    }
    
    private func setupAddSubview(){
        view.addSubview(navBar)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navBar.heightAnchor.constraint(equalToConstant: 80),
            ])
    }
    
    @objc func didTapMenuButton(){
        navigationController?.popToRootViewController(animated: true)
    }

}

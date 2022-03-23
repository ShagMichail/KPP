//
//  BuyVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import UIKit


protocol BuyDelegate: AnyObject {
    func didTapMenuButton()
}

protocol BuyInput: AnyObject {
    func didReceive(_ cars: [Cars])
}


class BuyVC: UIViewController {

    private var datasource: [Cars] = []
    
    private let model: BuyDescription = BuyModel()
    //guard let title = UIL
    private let table = UITableView()
    var flag = Bool()
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
        setupModel()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        
    }
    
    func setupModel(){
        model.loadPhoto()
        model.output = self
    }
    
    func setupTableView() {
        
        table.register(BuyCell.self, forCellReuseIdentifier: BuyCell.identifireBuy)
    }
    
    private func setupElement(){
        view.backgroundColor = .systemBackground
        
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.showsHorizontalScrollIndicator = false
        table.showsVerticalScrollIndicator = false
        table.separatorColor = UIColor.white
        
    }
    
    func setupNavBar(){
        navBar.navButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        navBar.navButton.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
    }
    
    private func setupAddSubview(){
        view.addSubview(navBar)
        view.addSubview(table)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navBar.heightAnchor.constraint(equalToConstant: 80),
            
            table.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
    }
    
    @objc func didTapMenuButton(){
        navigationController?.popToRootViewController(animated: true)
    }

}

extension BuyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if let cell = tableView.dequeueReusableCell(withIdentifier: BuyCell.identifireBuy, for: indexPath) as? BuyCell {
//            let cars: Cars
//            if isFiltering {
//                product = searchFilter[indexPath.row]
//            } else {
//                product = products[indexPath.row]
//            }
//            cell.configure(with: cars)
//            let imageView = cell.getImageView()
//            let imageURL: UILabel = {
//                let label = UILabel()
//                label.text = product.name + ".jpeg"
//                return label
//            }()
//            setImage(for: imageView, with: imageURL.text ?? "vk.jpeg")
//            cell.delegate = delegateController
//            return cell
//        }
//        return  .init()
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: BuyCell.identifireBuy, for: indexPath) as? BuyCell {
            
            let cars = datasource[indexPath.row]
            cell.configure(with: cars)
            if flag {
                cell.viewBackground.backgroundColor = UIColor.systemPurple
            } else {
                cell.viewBackground.backgroundColor = UIColor.systemBlue
            }
            return cell
        }
        return .init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let car = datasource[indexPath.row]
        guard let cell = tableView.cellForRow(at: indexPath) as? BuyCell else { return }
        let imageCell = cell.getImage()
        let rootVC = CarCardVC()
        rootVC.navBar.navTitle.text = navBar.navTitle.text
        rootVC.navBar.backgroundColor = navBar.backgroundColor
        rootVC.carImageView.image = imageCell
        rootVC.configure(with: car)
        navigationController?.pushViewController(rootVC, animated: true)
    }
}
    
    
    


extension BuyVC: BuyInput {
    func didReceive(_ cars: [Cars]) {
        self.datasource = cars
        table.reloadData()
    }
}

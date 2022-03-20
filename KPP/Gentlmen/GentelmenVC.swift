//
//  GentelmenVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 25.02.2022.
//

import UIKit

protocol CollectionViewGentlmenInput: AnyObject {
    func didReceive(_ gentlmen: [GentlmenPhoto])
}

protocol GentelmenVCDelegate: AnyObject {
    func didTapMenuButton()
}

class GentelmenVC: UIViewController {

    private let imageView = UIImageView()
    private let label = UILabel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    weak var delegate: GentelmenVCDelegate?
    
    private let buttonSell: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(sellButton), for: .touchUpInside)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        let attriburedTitle = NSMutableAttributedString(string: "Продать",
                                                        attributes: atts)
        button.setAttributedTitle(attriburedTitle, for: .normal)
        
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
        
        return button
    }()
    
    private let buttonCommission: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(commissionButton), for: .touchUpInside)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        let attriburedTitle = NSMutableAttributedString(string: "Комиссия",
                                                        attributes: atts)
        button.setAttributedTitle(attriburedTitle, for: .normal)
        
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
        
        return button
    }()
     
    private let buttonBuy: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(buyButtom), for: .touchUpInside)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        let attriburedTitle = NSMutableAttributedString(string: "Купить",
                                                        attributes: atts)
        button.setAttributedTitle(attriburedTitle, for: .normal)
        
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
        
        return button
    }()
    
    private let navBar: CustomNav = {
        let view = CustomNav()
        view.navTitle.text = "Джентельмены синдиката"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = PhotoTableLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .init(), collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    private var datasource: [GentlmenPhoto] = []
    
    private let model: CollectionModelGentlmenPhotoDescription = GentlmenModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        setupLabel()
        setupButton()
        setupAddSubview()
        setupLayout()
        setupImageView()
        setupModel()
        setupCollectionView()
    }
    
    func setupModel(){
        model.loadGentlmenPhoto()
        model.output = self
    }
    
    private func setupImageView(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gentlmen")
    }
    
    private func setupLabel(){
        label.text = "Добро пожаловать на страницу Джентельменов синдиката. Здесь вы сможете найти автомобиль по низу рынка. Также можете реализовать ваш автомобиль через нас либо продать нам его, если предложение будет очень горячие!!!"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GentlmenCell.self, forCellWithReuseIdentifier: GentlmenCell.identifireGentlmenPhoto)
    }
    
    private func setupButton(){
        buttonBuy.translatesAutoresizingMaskIntoConstraints = false
        buttonSell.translatesAutoresizingMaskIntoConstraints = false
        buttonCommission.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAddSubview(){
        view.addSubview(scrollView)
        view.addSubview(navBar)
        scrollView.addSubview(contentView)
        scrollView.addSubview(collectionView)
        //scrollView.addSubview(imageView)
        scrollView.addSubview(label)
        scrollView.addSubview(buttonBuy)
        scrollView.addSubview(buttonSell)
        scrollView.addSubview(buttonCommission)
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navBar.heightAnchor.constraint(equalToConstant: 80),
            
            
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            
            collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            
            label.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            buttonBuy.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            buttonBuy.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width / 4),
            buttonBuy.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(UIScreen.main.bounds.width / 4)),
            buttonBuy.heightAnchor.constraint(equalToConstant: 35),

            buttonSell.topAnchor.constraint(equalTo: buttonBuy.bottomAnchor, constant: 20),
            buttonSell.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width / 4),
            buttonSell.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(UIScreen.main.bounds.width / 4)),
            buttonSell.heightAnchor.constraint(equalToConstant: 35),
            
            buttonCommission.topAnchor.constraint(equalTo: buttonSell.bottomAnchor, constant: 20),
            buttonCommission.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIScreen.main.bounds.width / 4),
            buttonCommission.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(UIScreen.main.bounds.width / 4)),
            buttonCommission.heightAnchor.constraint(equalToConstant: 35),
            
        ])

    }
    
    private func setupNavBar(){
        navBar.navButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        navBar.navButton.setImage(UIImage(systemName: "list.dash"), for: .normal)
    }
    
    @objc func sellButton(){
        let rootVC = SellVC()
        rootVC.navBar.navTitle.text = navBar.navTitle.text
        rootVC.navBar.backgroundColor = navBar.backgroundColor
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc func commissionButton(){
        let rootVC = CommissionVC()
        rootVC.navBar.navTitle.text = navBar.navTitle.text
        rootVC.navBar.backgroundColor = navBar.backgroundColor
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc func buyButtom() {
        let rootVC = BuyVC()
        rootVC.navBar.navTitle.text = navBar.navTitle.text
        rootVC.navBar.backgroundColor = navBar.backgroundColor
        rootVC.flag = false
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }
}

// MARK: - UICollectionViewDataSource
extension GentelmenVC: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return datasource.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GentlmenCell.identifireGentlmenPhoto, for: indexPath) as? GentlmenCell {
            
            let gentlmen = datasource[indexPath.row]
            cell.configure(with: gentlmen)
            
            return cell
        }
        return .init()
    }
}

// MARK: - Flow Layout
extension GentelmenVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 50, left: 25, bottom: 50, right: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // TODO: В константы
        let width = UIScreen.main.bounds.width - 50
        return .init(width: width, height: collectionView.bounds.height)
    }
}

extension GentelmenVC: CollectionViewGentlmenInput {
    func didReceive(_ gentlmen: [GentlmenPhoto]) {
        self.datasource = gentlmen
        collectionView.reloadData()
    }
}

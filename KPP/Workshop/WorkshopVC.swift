//
//  WorkshopVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 25.02.2022.
//

import UIKit

protocol CollectionViewWorkshopInput: AnyObject {
    func didReceive(_ workshop: [WorkshopPhoto])
}

protocol WorkshopVCDelegate: AnyObject {
    func didTapMenuButton()
}

class WorkshopVC: UIViewController {
    
    private let imageViewServise = UIImageView()
    private let imageViewDetailing = UIImageView()
    private let label = UILabel()
    weak var delegate: WorkshopVCDelegate?
    
    private let buttonService: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(serviceButton), for: .touchUpInside)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15)]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        let attriburedTitle = NSMutableAttributedString(string: "Сервис",
                                                        attributes: atts)
        button.setAttributedTitle(attriburedTitle, for: .normal)
        
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
        
        return button
    }()
    
    private let buttonDetailing: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(detailingButton), for: .touchUpInside)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15)]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        let attriburedTitle = NSMutableAttributedString(string: "Детейлинг",
                                                        attributes: atts)
        button.setAttributedTitle(attriburedTitle, for: .normal)
        
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
        
        return button
    }()
    
    private let navBar: CustomNav = {
        let view = CustomNav()
        view.navTitle.text = "Мастерская синдиката"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.green
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
    
    private var datasource: [WorkshopPhoto] = []
    
    private let model: CollectionModelWorkshopPhotoDescription = WorkshopModel()
     
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
        model.loadWorkshopPhoto()
        model.output = self
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.register(WorkshopCell.self, forCellWithReuseIdentifier: WorkshopCell.identifireWorkshopPhoto)
        //collectionView.backgroundColor = UIColor.background
    }
    
    private func setupImageView(){
        imageViewServise.translatesAutoresizingMaskIntoConstraints = false
        imageViewServise.image = UIImage(named: "master")
        
        imageViewDetailing.translatesAutoresizingMaskIntoConstraints = false
        imageViewDetailing.image = UIImage(named: "detailing")
        imageViewDetailing.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
        imageViewServise.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width/4, height: UIScreen.main.bounds.width/4)
        
        imageViewServise.makeRounded()
        imageViewDetailing.makeRounded()
    }
    
    private func setupLabel(){
        label.text = "Добро пожаловать на страницу Мастерской синдиката. Здесь вы сможете записать в сервис под руководством Вадима или на детейлинг под руководством Александра. Обещаем, ваш автомобиль вернется к вам в сохраности и надежности)"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
    }
    
    private func setupButton(){
        buttonService.translatesAutoresizingMaskIntoConstraints = false
        buttonDetailing.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupAddSubview(){
        view.addSubview(navBar)
        view.addSubview(collectionView)
        view.addSubview(imageViewServise)
        view.addSubview(imageViewDetailing)
        view.addSubview(label)
        view.addSubview(buttonService)
        view.addSubview(buttonDetailing)

    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navBar.heightAnchor.constraint(equalToConstant: 80),
            
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 10),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            
            label.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            imageViewServise.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            imageViewServise.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            imageViewServise.heightAnchor.constraint(equalToConstant: 150),
            imageViewServise.widthAnchor.constraint(equalToConstant: 150),
            
            imageViewDetailing.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            imageViewDetailing.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            imageViewDetailing.heightAnchor.constraint(equalToConstant: 150),
            imageViewDetailing.widthAnchor.constraint(equalToConstant: 150),
            
            buttonService.topAnchor.constraint(equalTo: imageViewServise.bottomAnchor, constant: 20),
            buttonService.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            buttonService.heightAnchor.constraint(equalToConstant: 35),
            buttonService.widthAnchor.constraint(equalToConstant: 150),

            buttonDetailing.topAnchor.constraint(equalTo: imageViewDetailing.bottomAnchor, constant: 20),
            buttonDetailing.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            buttonDetailing.heightAnchor.constraint(equalToConstant: 35),
            buttonDetailing.widthAnchor.constraint(equalToConstant: 150),
            
            
            
        ])

    }
    
    private func setupNavBar(){
        navBar.navButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        navBar.navButton.setImage(UIImage(systemName: "list.dash"), for: .normal)
    }
    
    @objc func detailingButton(){
        let rootVC = DetailingVC()
        rootVC.navBar.navTitle.text = navBar.navTitle.text
        rootVC.navBar.backgroundColor = navBar.backgroundColor
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc func serviceButton() {
        let rootVC = ServiceVC()
        rootVC.navBar.navTitle.text = navBar.navTitle.text
        rootVC.navBar.backgroundColor = navBar.backgroundColor
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }
}

// MARK: - UICollectionViewDataSource
extension WorkshopVC: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return datasource.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkshopCell.identifireWorkshopPhoto, for: indexPath) as? WorkshopCell {
            
            let workshop = datasource[indexPath.row]
            cell.configure(with: workshop)
            
            return cell
        }
        return .init()
    }
}

// MARK: - Flow Layout
extension WorkshopVC: UICollectionViewDelegateFlowLayout {
    
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

extension WorkshopVC: CollectionViewWorkshopInput {
    func didReceive(_ workshop: [WorkshopPhoto]) {
        self.datasource = workshop
        collectionView.reloadData()
    }
}

//
//  ChestAvtoVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 25.02.2022.
//

import UIKit

protocol ChestAvtoVCDelegate: AnyObject {
    func didTapMenuButton()
}

protocol CollectionViewChestInput: AnyObject {
    func didReceive(_ photo: [Photo])
}

class ChestAvtoVC: UIViewController {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    weak var delegate: ChestAvtoVCDelegate?
    
    private let buttonSell: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(sellButton), for: .touchUpInside)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 18)]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        let attriburedTitle = NSMutableAttributedString(string: "Продать",
                                                        attributes: atts)
        button.setAttributedTitle(attriburedTitle, for: .normal)
        
        button.backgroundColor = UIColor.systemPurple
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
        
        button.backgroundColor = UIColor.systemPurple
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
        
        button.backgroundColor = UIColor.systemPurple
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
        
        return button
    }()
    
    private let navBar: CustomNav = {
        let view = CustomNav()
        view.navTitle.text = "Chest Avto"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.purple
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
    
    private var datasource: [Photo] = []
    
    private let model: CollectionModelPhotoDescription = PhotoModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        setupLabel()
        setupButton()
        setupAddSubview()
        setupLayout()
        setupImageView()
        setupCollectionView()
        setupModel()
    }
    
    private func setupImageView(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "chest")
    }
    
    func setupModel(){
        model.loadPhoto()
        model.output = self
    }
    
    private func setupLabel(){
        label.text = "Добро пожаловать на страницу Chest Avto. Мы продадим ваш атомобиль, а может даже и выкупим! Также можете посмотреть, что вам интересно и выбрать. Chest Avto рассматривает только премиум сегмент и в хорошем состоянии. "
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.isUserInteractionEnabled = true
        contentView.isMultipleTouchEnabled = true
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.isMultipleTouchEnabled = true
        
    }
    
    private func setupButton(){
        buttonBuy.translatesAutoresizingMaskIntoConstraints = false
        buttonSell.translatesAutoresizingMaskIntoConstraints = false
        buttonCommission.translatesAutoresizingMaskIntoConstraints = false
        
 }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifirePhoto)

    }
    
    private func setupAddSubview(){
        view.addSubview(scrollView)
        view.addSubview(navBar)
        scrollView.addSubview(contentView)
        
        scrollView.addSubview(collectionView)
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
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            buttonBuy.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            buttonBuy.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIScreen.main.bounds.width / 4),
            buttonBuy.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(UIScreen.main.bounds.width / 4)),

            buttonSell.topAnchor.constraint(equalTo: buttonBuy.bottomAnchor, constant: 20),
            buttonSell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIScreen.main.bounds.width / 4),
            buttonSell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(UIScreen.main.bounds.width / 4)),

            buttonCommission.topAnchor.constraint(equalTo: buttonSell.bottomAnchor, constant: 20),
            buttonCommission.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIScreen.main.bounds.width / 4),
            buttonCommission.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -(UIScreen.main.bounds.width / 4)),
            
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
        navigationController?.pushViewController(rootVC, animated: true)
    }
    
    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }

}

extension ChestAvtoVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

                     print ("Прокрутка")
            print(scrollView.contentOffset)


        }
             // 2. Вызывается, когда scrollView собирается начать перетаскивание
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {

                     print ("начнет перетаскивать")
        }
             // 3. Звонит тот, который прекратит перетаскивать (отпускание руки не означает прекращение прокрутки)
             // Параметр 2: скорость по оси x и по оси y при отпускании руки
             // Параметр 3: предварительно оцененное смещение при остановке прокрутки
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
                     print ("перетащить перестанет")

        }

             // 4. Он будет вызываться при остановке замедления (по сути, он вызывается при остановке прокрутки)
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
                     print ("Вызывается при остановке замедления")
        }

             // 5. Вызывается, когда рука собирается прекратить перетаскивать
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
                     print ("начнёт замедляться")
        }

             // 6. Вызывается, когда анимация прокрутки была остановлена
             // Этот метод вызывается только тогда, когда scrollView прокручивается с использованием эффекта анимации метода setContentOffset, и когда прокрутка остановлена
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
                     print ("Остановить прокрутку анимации")
        }

             // 7. Используется только в том случае, если строка состояния автоматически прокручивается вверх при нажатии на строку состояния.
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
                     print ("прокручен вверх")
        }
}

// MARK: - UICollectionViewDataSource
extension ChestAvtoVC: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return datasource.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifirePhoto, for: indexPath) as? PhotoCell {
            
            let photo = datasource[indexPath.row]
            cell.configure(with: photo)
            
            return cell
        }
        return .init()
    }
}

// MARK: - Flow Layout
extension ChestAvtoVC: UICollectionViewDelegateFlowLayout {
    
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

extension ChestAvtoVC: CollectionViewChestInput {
    func didReceive(_ photo: [Photo]) {
        self.datasource = photo
        collectionView.reloadData()
    }
}

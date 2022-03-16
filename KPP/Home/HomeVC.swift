//
//  HomeVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 24.02.2022.
//

import UIKit

protocol HomeVCDelegate: AnyObject {
    func didTapMenuButton()
}

protocol CollectionViewControllerInput: AnyObject {
    func didReceive(_ human: [Human])
}

class HomeVC: UIViewController {

    weak var delegate: HomeVCDelegate?
    private let moscowImageView = UIImageView()
    private let evgenImageView = UIImageView()
    private let message = UILabel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let link = UILabel()
    private lazy var collectionView: UICollectionView = {
        let layout = HomeTableLayout()
        layout.scrollDirection = .horizontal
        
        let collection = UICollectionView(frame: .init(), collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.isPagingEnabled = false
       
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    private var datasource: [Human] = []
    
    private let model: CollectionModelDescription = HumanModel()
 
    private let navBar: CustomNav = {
        let view = CustomNav()
        view.navTitle.text = "Дубровский синдикат"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupAdd()
        setupImageView()
        setupLabel()
        setupMenu()
        setupLayout()
        setupCollectionView()
        setupModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        collectionView.reloadData()
    }
    
    func setupModel(){
        model.loadHuman()
        model.output = self
    }
    
    func setupNavBar(){
        navBar.navButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        navBar.navButton.setImage(UIImage(systemName: "list.dash"), for: .normal)
    }
    
    private func setupAdd(){
        view.addSubview(navBar)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(moscowImageView)
        contentView.addSubview(message)
        contentView.addSubview(collectionView)

        
    }
    
    private func setupView(){
        view.backgroundColor = .systemBackground

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
        scrollView.showsVerticalScrollIndicator = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
    
    }
    
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HumanCell.self, forCellWithReuseIdentifier: HumanCell.identifire)
    }
    
    private func setupImageView(){
        moscowImageView.image = UIImage(named: "moscow")
        moscowImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    private func setupLabel(){
        message.textColor = UIColor.black
        message.font = UIFont(name: "TimesNewRomanPSMT", size: 20)
        message.textAlignment = .center
        message.translatesAutoresizingMaskIntoConstraints = false
        message.text = "Добро пожаловать в наше приложение! Здесь вы можете увидеть каких успехов мы достигли! Здесь вы сможете посмотреть автомобили, которые есть в ассортименте Джентельменов и Честавто. Сможете записаться на сервис или детейлинг в нашу Мастерскую.Добро пожаловать в наше приложение! Здесь вы можете увидеть каких успехов мы достигли! Здесь вы сможете посмотреть автомобили, которые есть в ассортименте Джентельменов и Честавто. Сможете записаться на сервис или детейлинг в нашу Мастерскую."
        message.numberOfLines = 0
        
        
    }
    
    private func setupMenu(){

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
            
            
            moscowImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            moscowImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            moscowImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            moscowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            collectionView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: moscowImageView.bottomAnchor, constant: 25),
            collectionView.heightAnchor.constraint(equalToConstant: 130),
            
            message.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            message.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 15),
            message.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            message.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            message.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

        ])
    }
    
    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }
}

extension HomeVC: UIScrollViewDelegate {
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
extension HomeVC: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return datasource.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HumanCell.identifire, for: indexPath) as? HumanCell {
            
            let human = datasource[indexPath.row]
            cell.configure(with: human)
            
            return cell
        }
        return .init()
    }
}

// MARK: - Flow Layout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    
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

extension HomeVC: CollectionViewControllerInput {
    func didReceive(_ human: [Human]) {
        self.datasource = human
        collectionView.reloadData()
    }
}

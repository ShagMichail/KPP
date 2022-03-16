//
//  MenuVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 24.02.2022.
//

import UIKit

protocol MenuVCDelegate: AnyObject {
    func didSelect(menuItem: MenuVC.MenuOptions)
}
class MenuVC: UIViewController {
    
    weak var delegate: MenuVCDelegate?

    enum MenuOptions: String, CaseIterable {
        case home = "Домашняя страница"
        case chestAvto = "ChestAvto"
        case workshop = "Мастерская"
        case gentlemen = "Джентельмены"
        case info = "Контактная информация"
        
        var imageName: String {
            switch self {
            case .home:
                return "house"
            case .info:
                return "person.fill.questionmark"
            case .chestAvto:
                return "star"
            case .workshop:
                return "gear"
            case .gentlemen:
                return "person.3.fill"
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.backgroundColor = nil
        return table
    }()
    
    private let grayColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTable()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }

    private func setupView(){
        view.backgroundColor = grayColor
    }
    
    private func setupTable(){
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

extension MenuVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let item = MenuOptions.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}

extension MenuVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOptions.allCases[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.imageView?.tintColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOptions.allCases[indexPath.row].imageName)
        
        cell.backgroundColor = grayColor
        cell.contentView.backgroundColor = grayColor
        return cell
    }
    
        
}

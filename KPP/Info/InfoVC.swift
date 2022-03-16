//
//  InfoVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 24.02.2022.
//

import UIKit

protocol InfoVCDelegate: AnyObject {
    func didTapMenuButton()
}

class InfoVC: UIViewController {

    private let imageHelp = UIImageView()
    private let labelPhoneSupport = UILabel()
    private let labelPhoneCooperation = UILabel()
    private let labelEmailSupport = UILabel()
    private let labelEmailCooperation = UILabel()
    private let message = UILabel()
    private let messageSupport = UILabel()
    private let messageCooperation = UILabel()
    weak var delegate: InfoVCDelegate?
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let navBar: CustomNav = {
        let view = CustomNav()
        view.navTitle.text = "Контакты"
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        setupAddSubview()
        setupImageView()
        setupLayout()
        setupLabel()
        
    }
    
    private func setupNavBar(){
        navBar.navButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        navBar.navButton.setImage(UIImage(systemName: "list.dash"), for: .normal)
    }

    private func setupImageView(){
        imageHelp.image = UIImage(named: "help")
        imageHelp.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func setupLabel(){
        labelPhoneSupport.text = "+7-999-999-99-99"
        labelPhoneSupport.translatesAutoresizingMaskIntoConstraints = false
        
        labelPhoneCooperation.text = "+7-888-888-88-88"
        labelPhoneCooperation.translatesAutoresizingMaskIntoConstraints = false
        
        labelEmailCooperation.text = "dubrovsriy@mail.ru"
        labelEmailCooperation.translatesAutoresizingMaskIntoConstraints = false
        
        labelEmailSupport.text = "syndikat@.mail.ru"
        labelEmailSupport.translatesAutoresizingMaskIntoConstraints = false
        
        message.text = "Здесь расположены наши контакты:"
        message.numberOfLines = 0
        message.translatesAutoresizingMaskIntoConstraints = false
        
        messageSupport.text = "Здесь расположены наши контакты по общим вопросам:"
        messageSupport.numberOfLines = 0
        messageSupport.translatesAutoresizingMaskIntoConstraints = false
        
        messageCooperation.text = "Здесь расположены наши контакты для сотрудничества:"
        messageCooperation.numberOfLines = 0
        messageCooperation.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.alwaysBounceHorizontal = false
    }
    
    private func setupAddSubview(){
        view.addSubview(scrollView)
        view.addSubview(navBar)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageHelp)
        contentView.addSubview(labelEmailSupport)
        contentView.addSubview(labelPhoneSupport)
        contentView.addSubview(labelEmailCooperation)
        contentView.addSubview(labelPhoneCooperation)
        contentView.addSubview(message)
        contentView.addSubview(messageSupport)
        contentView.addSubview(messageCooperation)
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
            
            imageHelp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageHelp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            imageHelp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageHelp.heightAnchor.constraint(equalToConstant: 250),
            
            message.topAnchor.constraint(equalTo: imageHelp.bottomAnchor, constant: 30),
            message.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            message.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            messageSupport.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 20),
            messageSupport.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageSupport.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelPhoneSupport.topAnchor.constraint(equalTo: messageSupport.bottomAnchor, constant: 20),
            labelPhoneSupport.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelPhoneSupport.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelEmailSupport.topAnchor.constraint(equalTo: labelPhoneSupport.bottomAnchor, constant: 20),
            labelEmailSupport.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelEmailSupport.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            messageCooperation.topAnchor.constraint(equalTo: labelEmailSupport.bottomAnchor, constant: 30),
            messageCooperation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageCooperation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelPhoneCooperation.topAnchor.constraint(equalTo: messageCooperation.bottomAnchor, constant: 20),
            labelPhoneCooperation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelPhoneCooperation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            labelEmailCooperation.topAnchor.constraint(equalTo: labelPhoneCooperation.bottomAnchor, constant: 20),
            labelEmailCooperation.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelEmailCooperation.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
        ])
    }
    
    @objc func didTapMenuButton(){
        delegate?.didTapMenuButton()
    }
}

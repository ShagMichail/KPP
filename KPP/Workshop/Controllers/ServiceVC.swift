//
//  ServiceVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import UIKit

class ServiceVC: UIViewController {

    var activeTextField : UITextField? = nil
    //для форматирования строки телефона
    private let maxNumberCount = 11
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    
    private let label = UILabel()
    
    private let buttonSend: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(sendButton), for: .touchUpInside)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15)]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        let attriburedTitle = NSMutableAttributedString(string: "Отправить",
                                                        attributes: atts)
        button.setAttributedTitle(attriburedTitle, for: .normal)
        
        button.backgroundColor = UIColor.systemGreen
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let fullnameTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Fullname")
        tf.returnKeyType = .done
        tf.textContentType = .name
        tf.keyboardAppearance = .light
        return tf
    }()
    
    private let numberTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Phone")
        tf.returnKeyType = .done
        tf.textContentType = .telephoneNumber
        tf.keyboardType = .numberPad
        tf.keyboardAppearance = .light
        tf.addDoneCanselToolBar()
        
        return tf
    }()
    
    private let emailTextField: CustomTextField = {
        let tf = CustomTextField(placeholder: "Email")
        tf.returnKeyType = .done
        tf.keyboardType = .emailAddress
        tf.textContentType = .emailAddress
        tf.keyboardAppearance = .light
        return tf
    }()
    
    private let stampTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Stamp")
        tf.returnKeyType = .done
        tf.textContentType = .addressCity
        tf.keyboardAppearance = .light
        return tf
    }()
    
    private let modelTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Model")
        tf.returnKeyType = .done
        tf.textContentType = .addressCity
        tf.keyboardAppearance = .light
        return tf
    }()
    
    private let yearTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Year")
        tf.returnKeyType = .done
        tf.textContentType = .addressCity
        tf.keyboardAppearance = .light
        return tf
    }()
    
    private let detailingTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Service")
        tf.returnKeyType = .done
        tf.textContentType = .addressCity
        tf.keyboardAppearance = .light
        return tf
    }()
    
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
        setupDelegate()
        setupLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        
    }
    
    private func setupElement(){
        view.backgroundColor = .systemBackground
        stampTextField.tintColor = navBar.backgroundColor
        fullnameTextField.tintColor = navBar.backgroundColor
        modelTextField.tintColor = navBar.backgroundColor
        numberTextField.tintColor = navBar.backgroundColor
        emailTextField.tintColor = navBar.backgroundColor
        yearTextField.tintColor = navBar.backgroundColor
        detailingTextField.tintColor = navBar.backgroundColor
    }
    
    func setupDelegate(){
        stampTextField.delegate = self
        fullnameTextField.delegate = self
        modelTextField.delegate = self
        numberTextField.delegate = self
        emailTextField.delegate = self
        yearTextField.delegate = self
        detailingTextField.delegate = self
    }
    
    func setupNavBar(){
        navBar.navButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        navBar.navButton.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
    }
    
    private func setupLabel(){
        label.text = "Все очень просто! Заполняете заявку с уточнением особенностей своего автомобиля и выбираете вид работы. После чего ждете обратной связи от наших сотрудников!"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
    }
    
    private func setupAddSubview(){
        view.addSubview(navBar)
        view.addSubview(label)
        view.addSubview(numberTextField)
        view.addSubview(yearTextField)
        view.addSubview(fullnameTextField)
        view.addSubview(emailTextField)
        view.addSubview(stampTextField)
        view.addSubview(modelTextField)
        view.addSubview(detailingTextField)
        view.addSubview(buttonSend)
    }
    
    private func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }
               
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
        
        if number.count > maxNumberCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
            
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
        }
        
        if number.count == 1 {
            return "+" + "7"
        } else {
            return "+" + number
        }
    }
    
    private func setupLayout(){
        NSLayoutConstraint.activate([
            
            navBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            navBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            navBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            navBar.heightAnchor.constraint(equalToConstant: 80),
            
            label.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 15),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            fullnameTextField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
            fullnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fullnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            stampTextField.topAnchor.constraint(equalTo: fullnameTextField.bottomAnchor, constant: 15),
            stampTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stampTextField.widthAnchor.constraint(equalToConstant: view.bounds.width/3 - 20),
            
            modelTextField.topAnchor.constraint(equalTo: fullnameTextField.bottomAnchor, constant: 15),
            modelTextField.leadingAnchor.constraint(equalTo: stampTextField.trailingAnchor, constant: 10),
            modelTextField.widthAnchor.constraint(equalToConstant: view.bounds.width/3 - 20),
            
            yearTextField.topAnchor.constraint(equalTo: fullnameTextField.bottomAnchor, constant: 15),
            yearTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            yearTextField.widthAnchor.constraint(equalToConstant: view.bounds.width/3 - 20),
            
            detailingTextField.topAnchor.constraint(equalTo: yearTextField.bottomAnchor, constant: 15),
            detailingTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailingTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            numberTextField.topAnchor.constraint(equalTo: detailingTextField.bottomAnchor, constant: 15),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 15),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            buttonSend.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            //buttonSend.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            buttonSend.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonSend.heightAnchor.constraint(equalToConstant: 35),
            buttonSend.widthAnchor.constraint(equalToConstant: 150),
            
            ])
    }
    
    @objc func didTapMenuButton(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func sendButton() {
        var name = fullnameTextField.text!
        var email = emailTextField.text!
        var year = yearTextField.text!
        var number = numberTextField.text!
        var model = modelTextField.text!
        var stamp = stampTextField.text!
        var detailing = detailingTextField.text!
        if (!name.isEmpty && !email.isEmpty && !model.isEmpty && !number.isEmpty && !stamp.isEmpty && !year.isEmpty) {
            
            fullnameTextField.text = ""
            emailTextField.text = ""
            yearTextField.text = ""
            numberTextField.text = ""
            modelTextField.text = ""
            stampTextField.text = ""
            detailingTextField.text = ""
            
        }
    }

}


extension ServiceVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        modelTextField.resignFirstResponder()
        fullnameTextField.resignFirstResponder()
        yearTextField.resignFirstResponder()
        numberTextField.resignFirstResponder()
        stampTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        detailingTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == numberTextField {
            let fullString = (textField.text ?? "") + string
            textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
            return false
        } else {
        return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
}

extension ServiceVC {
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ServiceVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ServiceVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func keyboardWillShow(notification: NSNotification) {
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            // if keyboard size is not available for some reason, dont do anything
//           return
//        }
//
//        var shouldMoveViewUpCity = false
//        var scholdMoveViewUpNum = false
//
//        if let activeTextField = activeTextField {
//            let bottomOfTextField = activeTextField.convert(activeTextField.bounds, to: self.view).maxY;
//            let topOfKeyboard = self.view.frame.height - keyboardSize.height
//
//            if activeTextField == cityTextField {
//                if bottomOfTextField > topOfKeyboard {
//                    shouldMoveViewUpCity = true
//                }
//            }
//            if activeTextField == numberTextField {
//                if bottomOfTextField > topOfKeyboard {
//                    scholdMoveViewUpNum = true
//                }
//            }
//        }
//
//        if(shouldMoveViewUpCity) {
//            self.view.frame.origin.y = 0 - keyboardSize.height/8
//        }
//        if(scholdMoveViewUpNum) {
//            self.view.frame.origin.y = 0 - keyboardSize.height/3
//        }

    }
    
    @objc
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}


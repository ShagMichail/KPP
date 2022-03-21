//
//  CommissionVC.swift
//  KPP
//
//  Created by Михаил Шаговитов on 10.03.2022.
//

import UIKit
import Photos
import PhotosUI

class CommissionVC: UIViewController {

    
    private let collectionPhoto: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.register(PhotoCarsCell.self, forCellWithReuseIdentifier: "cell")
        return c
        
    }()
    
    private var images = [UIImage]()
    
    
    
    var activeTextField : UITextField? = nil
    
    //для форматирования строки телефона
    private let maxNumberCount = 11
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    
    private let label = UILabel()
    private let question = UILabel()
    private var orVesNou = CustomSegmentedControl(frame: CGRect(x: 0, y: 0, width: 100, height: 30), buttonTitle: ["Да", "Нет"])
    //private var menuArray = ["да", "нет"]
    
    private let buttonSend: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(sendButton), for: .touchUpInside)
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.white, .font: UIFont.systemFont(ofSize: 15)]
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        let attriburedTitle = NSMutableAttributedString(string: "Отправить",
                                                        attributes: atts)
        button.setAttributedTitle(attriburedTitle, for: .normal)
        
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
    
    private let dayTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Sale period (in days)")
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
        //tf.returnKeyType = .done
        tf.textContentType = .addressCity
        tf.keyboardAppearance = .light
        tf.addDoneCanselToolBar()
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
        //tf.returnKeyType = .done
        tf.textContentType = .addressCity
        tf.keyboardAppearance = .light
        tf.addDoneCanselToolBar()
        return tf
    }()
    
    private let costTextField: CustomTextField = {
    let tf = CustomTextField(placeholder: "Cost")
        tf.returnKeyType = .done
        //tf.textContentType = .addressCity
        tf.keyboardAppearance = .light
        tf.keyboardType = .numberPad
        return tf
    }()
    
    var navBar: CustomNav = {
        let view = CustomNav()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let photoCars = UILabel()
    private let newPhotoCars = UIButton(type: .system)
    
    private let pickerStampView = UIPickerView()
    private let pickerYearView = UIPickerView()
    private let pickerStampDatas = ["Audi", "Mersedes", "Land Rover", "Honda"]
    private let pickerYearDatas = ["1950","1960","1970","1980","1990","2000","2001","2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017","2018","2019","2020","2021","2022"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddSubview()
        setupLayout()
        setupDelegate()
        setupLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
        setupElement()
    }
    
    private func setupElement(){
        view.backgroundColor = .systemBackground
        buttonSend.backgroundColor = navBar.backgroundColor
        stampTextField.tintColor = navBar.backgroundColor
        fullnameTextField.tintColor = navBar.backgroundColor
        modelTextField.tintColor = navBar.backgroundColor
        numberTextField.tintColor = navBar.backgroundColor
        emailTextField.tintColor = navBar.backgroundColor
        yearTextField.tintColor = navBar.backgroundColor
        costTextField.tintColor = navBar.backgroundColor
        dayTextField.tintColor = navBar.backgroundColor
    }
    
    func setupDelegate(){
        stampTextField.delegate = self
        fullnameTextField.delegate = self
        modelTextField.delegate = self
        numberTextField.delegate = self
        emailTextField.delegate = self
        yearTextField.delegate = self
        costTextField.delegate = self
        dayTextField.delegate = self
    }
    
    func setupNavBar(){
        navBar.navButton.addTarget(self, action: #selector(didTapMenuButton), for: .touchUpInside)
        navigationController?.navigationBar.isHidden = true
        navBar.navButton.setImage(UIImage(systemName: "arrowshape.turn.up.left"), for: .normal)
    }

    
    private func setupLabel(){
        label.text = "Все очень просто! Заполняете заявку с уточнением особенностей своего автомобиля и особенности стоимости. После чего ждете обратной связи от наших сотрудников!"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        
        question.text = "Торг уместен?"
        question.numberOfLines = 0
        question.translatesAutoresizingMaskIntoConstraints = false
        question.textAlignment = .center
        
        
        orVesNou.translatesAutoresizingMaskIntoConstraints = false
        orVesNou.backgroundColor = .clear
        
        photoCars.text = "Фото автомобиля"
        photoCars.numberOfLines = 0
        photoCars.translatesAutoresizingMaskIntoConstraints = false
        //photoCars.textAlignment = .center
        
        newPhotoCars.translatesAutoresizingMaskIntoConstraints = false
        newPhotoCars.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        newPhotoCars.tintColor = .black
        newPhotoCars.addTarget(self, action: #selector(didTapAdd), for: .touchUpInside)
        
        collectionPhoto.translatesAutoresizingMaskIntoConstraints = false
        collectionPhoto.delegate = self
        collectionPhoto.dataSource = self
        
        pickerStampView.delegate = self
        pickerStampView.dataSource = self
        stampTextField.inputView = pickerStampView
        pickerStampView.tag = 1
        
        pickerYearView.delegate = self
        pickerYearView.dataSource = self
        yearTextField.inputView = pickerYearView
        pickerYearView.tag = 2
        
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
        view.addSubview(costTextField)
        view.addSubview(orVesNou)
        view.addSubview(question)
        view.addSubview(newPhotoCars)
        view.addSubview(photoCars)
        view.addSubview(buttonSend)
        view.addSubview(collectionPhoto)
        view.addSubview(dayTextField)

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
            
            
            dayTextField.topAnchor.constraint(equalTo: yearTextField.bottomAnchor, constant: 15),
            dayTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            dayTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            costTextField.topAnchor.constraint(equalTo: dayTextField.bottomAnchor, constant: 15),
            costTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            costTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            question.topAnchor.constraint(equalTo: costTextField.bottomAnchor, constant: 15),
            question.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            

            orVesNou.topAnchor.constraint(equalTo: costTextField.bottomAnchor, constant: 10),

            orVesNou.leadingAnchor.constraint(equalTo: question.trailingAnchor, constant: 15),
            orVesNou.widthAnchor.constraint(equalToConstant: 100),
            orVesNou.heightAnchor.constraint(equalToConstant: 30),

            
            numberTextField.topAnchor.constraint(equalTo: question.bottomAnchor, constant: 15),
            numberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            numberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailTextField.topAnchor.constraint(equalTo: numberTextField.bottomAnchor, constant: 15),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            photoCars.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            photoCars.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            newPhotoCars.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 13.5),
            newPhotoCars.leadingAnchor.constraint(equalTo: photoCars.trailingAnchor, constant: 15),
            //newPhotoCars.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            collectionPhoto.topAnchor.constraint(equalTo: photoCars.bottomAnchor, constant: 10),
            collectionPhoto.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionPhoto.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            collectionPhoto.heightAnchor.constraint(equalToConstant: 100),
            
            
            buttonSend.topAnchor.constraint(equalTo: collectionPhoto.bottomAnchor, constant: 20),
            buttonSend.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonSend.heightAnchor.constraint(equalToConstant: 35),
            buttonSend.widthAnchor.constraint(equalToConstant: 150),
            
            
        ])
    }
    
    @objc func didTapAdd() {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.selectionLimit = 6
        config.filter = .images
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
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
        var cost = costTextField.text!
        var collection = images.count
        var day = dayTextField.text!
        if (!name.isEmpty && !email.isEmpty && !model.isEmpty && !day.isEmpty && !number.isEmpty && !stamp.isEmpty && !year.isEmpty && !cost.isEmpty && (collection != 0)) {
            
            fullnameTextField.text = ""
            emailTextField.text = ""
            yearTextField.text = ""
            numberTextField.text = ""
            modelTextField.text = ""
            stampTextField.text = ""
            costTextField.text = ""
            dayTextField.text = ""
            for i in 0...(images.count - 1) {
                images.remove(at: i)
            }
            collectionPhoto.reloadData()
            let alert = UIAlertController(title: "До связи!", message: "Ваша заявка успешно отправлена! Мы с вами свяжемся по указанным данным.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: { action
                in
                self.navigationController?.popToRootViewController(animated: true)

            } ))
            present(alert, animated: true)
            
        } else {
            let alert = UIAlertController(title: "Предупреждение", message: "Проверьте заполнение формы. Не все поля заполнены или заполнены неверно!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: { action
                in
                print("Отмена")

            } ))
            present(alert, animated: true)

        }
        
        

    }

}

extension CommissionVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true, completion: nil)
        
        let group = DispatchGroup()
        
        results.forEach { result in
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] reading, error in
                defer {
                    group.leave()
                }
                guard let image = reading as? UIImage, error == nil else {
                    return
                }
                self?.images.append(image)
            }
            
        }
        group.notify(queue: .main) {
            self.collectionPhoto.reloadData()
        }
    }
}


extension CommissionVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        modelTextField.resignFirstResponder()
        fullnameTextField.resignFirstResponder()
        yearTextField.resignFirstResponder()
        numberTextField.resignFirstResponder()
        stampTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        costTextField.resignFirstResponder()
        dayTextField.resignFirstResponder()
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

extension CommissionVC {
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


extension CommissionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCarsCell else {fatalError()}
        cell.imageView.image = images[indexPath.row]
        return cell
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let cell = collectionView.cellForItem(at: indexPath)
        let alert = UIAlertController(title: "Предупреждение", message: "Вы точно хотите удалить эту фотографию?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { action in
            print("Отмена")
        } ))
        
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive, handler: { action in
            
            for i in 0...self.images.count{
                if self.images[i] == self.images[indexPath.row] {
                    self.images.remove(at: i)
                    break
                }
            }
            cell?.removeFromSuperview()
            collectionView.reloadData()
        } ))
        
        present(alert, animated: true)
        
    }
}


extension CommissionVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return pickerStampDatas[row]
        case 2:
            return pickerYearDatas[row]
        default:
            return ""
        }
        
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return pickerStampDatas.count
        case 2:
            return pickerYearDatas.count
        default:
            return 1
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            stampTextField.text = pickerStampDatas[row]
        case 2:
            yearTextField.text = pickerYearDatas[row]
        default:
            return yearTextField.text = ""
        }
        
    }


}

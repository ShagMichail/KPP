//
//  CustomTextField.swift
//  KPP
//
//  Created by Михаил Шаговитов on 11.03.2022.
//


import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String){
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        layer.cornerRadius = 10
        
        borderStyle = .roundedRect
        
        textColor = UIColor.black //.withAlphaComponent(0.6)
        keyboardAppearance = .dark
        //backgroundColor = UIColor.green.withAlphaComponent(0.5)
        setHeight(height: 35)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.black.withAlphaComponent(0.6)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension UIView {
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}

extension UITextField {
    func addDoneCanselToolBar(onDone: (target: Any, action: Selector)? = nil, onCancle: (target: Any, action: Selector)? = nil) {
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))
        let onCancle = onCancle ?? (target: self, action: #selector(canselButtonTapped))
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancle.target, action: onCancle.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: onDone.target, action: onDone.action)
        ]
        toolBar.sizeToFit()
        self.inputAccessoryView = toolBar
    }
    
    @objc
    func doneButtonTapped() {
        self.resignFirstResponder()
    }
    @objc
    func canselButtonTapped() {
        self.resignFirstResponder()
    }
}

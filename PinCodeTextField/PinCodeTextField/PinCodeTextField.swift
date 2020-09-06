//
//  PinCodeTextField.swift
//  PinCodeTextField
//
//  Created by 侯博野 on 2020/9/6.
//  Copyright © 2020 satelens. All rights reserved.
//

import UIKit

class PinCodeTextField: UIView {
    let characterLimit: Int
    
    var text: String? {
        return targetTextField.text
    }
    
    override var backgroundColor: UIColor? {
        didSet {
            backgroundView.backgroundColor = backgroundColor
        }
    }
    
    private let targetTextField = UITextField()
    private let backgroundView = UIView()
    private let contentMaskView = UIView()
    private var observation: NSKeyValueObservation?
    private var items = [PinCodeTextFieldItemView]()
    
    init(characterLimit: Int) {
        self.characterLimit = characterLimit
        super.init(frame: CGRect.zero)
        addSubview(targetTextField)
        addSubview(backgroundView)
        addSubview(contentMaskView)
        
        targetTextField.delegate = self
        targetTextField.keyboardType = .numberPad
        
        targetTextField.addTarget(self, action: #selector(onEditingChanged(_:)), for: .editingChanged)
        let tap = UITapGestureRecognizer(target: self, action: #selector(textFieldTapAction))
        contentMaskView.addGestureRecognizer(tap)
        
        setupSubViews()
    }
    
    func cleanContent() {
        for itemView in items {
            itemView.text = nil
        }
    }
    
    @objc func textFieldBecomeFirstResponder() {
        targetTextField.becomeFirstResponder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundView.frame = bounds
        contentMaskView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PinCodeTextField {
    
    
    @objc private func onEditingChanged(_ tf: UITextField) {
        cleanContent()
        guard let resultText = tf.text else {
            return
        }
        for (index, char) in resultText.enumerated() {
            items[index].text = String(char)
        }
    }
    
    @objc private func textFieldTapAction() {
        if targetTextField.isFirstResponder {
            targetTextField.resignFirstResponder()
        } else {
            targetTextField.becomeFirstResponder()
        }
    }
    
    func setupSubViews() {
        items.removeAll()
        for index in 0..<characterLimit {
            let itemView = PinCodeTextFieldItemView()
            itemView.textAlignment = .center
            backgroundView.addSubview(itemView)
            itemView.frame = CGRect(x: Int(UIScreen.main.bounds.width) / characterLimit * index, y: 0, width: Int(UIScreen.main.bounds.width) / characterLimit, height: 60)
            items.append(itemView)
        }
    }
}

extension PinCodeTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let tergetString = textField.text else {
            return true
        }
        let beingString = (tergetString as NSString).replacingCharacters(in: range, with: string)
        if (beingString.count > characterLimit) {
            return false
        }
        return true
    }
}

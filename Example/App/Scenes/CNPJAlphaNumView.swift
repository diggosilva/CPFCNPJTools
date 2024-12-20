//
//  CNPJANView.swift
//  ExampleApp
//
//  Created by Diggo Silva on 20/12/24.
//

import UIKit

protocol CNPJAlphaNumViewDelegate: AnyObject {
    func validateCNPJAlphaNum()
    func generateCNPJAlphaNum()
}

class CNPJAlphaNumView: UIView {
    lazy var resultLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.font = .preferredFont(forTextStyle: .headline)
        lbl.font = .systemFont(ofSize: 30, weight: .semibold)
        return lbl
    }()
    
    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Digite o CNPJ alfanúmerico"
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .default
        tf.autocapitalizationType = .allCharacters
        tf.autocorrectionType = .no
        tf.addTarget(self, action: #selector(cnpjAlphaNumTextFieldMask), for: .editingChanged)
        return tf
    }()
    
    lazy var validateCNPJbutton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Validar CNPJ Alfanúmerico", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .systemBlue
        btn.addTarget(self, action: #selector(validateCNPJAlphaNum), for: .touchUpInside)
        return btn
    }()
    
    lazy var generateCNPJbutton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Gerar CNPJ Alfanúmerico", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .systemTeal
        btn.addTarget(self, action: #selector(generateCNPJAlphaNum), for: .touchUpInside)
        return btn
    }()
    
    var result = ""
//    var cnpjANManager = CNPJAlphaNumManager()
    weak var delegate: CNPJAlphaNumViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func cnpjAlphaNumTextFieldMask() {
//        let maskCNPJAlphaNum = cnpjANManager.mask(cnpjAlphaNum: textField.text ?? "")
//        textField.text = maskCNPJAlphaNum
//        CNPJAlphaNumResult = maskCNPJAlphaNum
    }
    
    @objc private func validateCNPJAlphaNum() {
        delegate?.validateCNPJAlphaNum()
    }
    
    @objc private func generateCNPJAlphaNum() {
        delegate?.generateCNPJAlphaNum()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        addSubviews([resultLabel, textField, validateCNPJbutton, generateCNPJbutton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            resultLabel.heightAnchor.constraint(equalToConstant: 150),
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            textField.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 30),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 300),
            
            validateCNPJbutton.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            validateCNPJbutton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            validateCNPJbutton.widthAnchor.constraint(equalToConstant: 200),
            
            generateCNPJbutton.centerXAnchor.constraint(equalTo: validateCNPJbutton.centerXAnchor),
            generateCNPJbutton.topAnchor.constraint(equalTo: validateCNPJbutton.bottomAnchor, constant: 30),
            generateCNPJbutton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}

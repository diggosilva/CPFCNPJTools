//
//  CNPJANView.swift
//  ExampleApp
//
//  Created by Diggo Silva on 15/12/24.
//

import UIKit

protocol CNPJAlphaNumViewDelegate: AnyObject {
    func validateCNPJAlphaNum()
    func generateCNPJAlphaNum()
}

class CNPJAlphaNumView: UIView {
    lazy var backgroundView: UIView = {
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 50
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner] // Apenas os cantos superior esquerdo e inferior direito
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowOpacity = 0.5
        bgView.layer.shadowRadius = 5.0
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.systemGray2.cgColor
        return bgView
    }()
    
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
    
    var CNPJAlphaNumResult = ""
    weak var delegate: CNPJAlphaNumViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func cnpjAlphaNumTextFieldMask() {
        var originalText = textField.text?.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        
        if originalText?.count ?? 0 > 14 {
            originalText = String(originalText?.prefix(14) ?? "")
        }
        
        var maskedText = ""
        
        if let unmaskedText = originalText {
            for (index, char) in unmaskedText.enumerated() {
                if index == 2 || index == 5 {
                    maskedText.append(".")
                } else if index == 8 {
                    maskedText.append("/")
                } else if index == 12 {
                    maskedText.append("-")
                }
                maskedText.append(char)
            }
        }
        textField.text = maskedText
        CNPJAlphaNumResult = maskedText
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
        addSubviews([backgroundView, resultLabel, textField, validateCNPJbutton, generateCNPJbutton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 150),
            backgroundView.widthAnchor.constraint(equalToConstant: 350),
            
            resultLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 30),
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

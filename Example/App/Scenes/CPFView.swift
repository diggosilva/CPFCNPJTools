//
//  CPFView.swift
//  CPF-CNPJ-TOOLS
//
//  Created by Diggo Silva on 16/11/24.
//

import UIKit
import CPFCNPJTools

protocol CPFViewDelegate: AnyObject {
    func validateCPF()
    func generateCPF()
}

class CPFView: UIView {
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
        tf.placeholder = "Digite o CPF"
        tf.borderStyle = .roundedRect
        tf.clearButtonMode = .whileEditing
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(cpfTextFieldMask), for: .editingChanged)
        return tf
    }()
    
    lazy var validateCPFbutton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Validar CPF", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .systemBlue
        btn.addTarget(self, action: #selector(validateCPF), for: .touchUpInside)
        return btn
    }()
    
    lazy var generateCPFbutton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Gerar CPF", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .systemIndigo
        btn.addTarget(self, action: #selector(generateCPF), for: .touchUpInside)
        return btn
    }()
    
    var result = ""
    weak var delegate: CPFViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func cpfTextFieldMask() {
        let maskCPF = CPFManager().mask(cpf: textField.text ?? "")
        textField.text = maskCPF
        result = maskCPF
    }
    
    @objc private func validateCPF() {
        delegate?.validateCPF()
    }
    
    @objc private func generateCPF() {
        delegate?.generateCPF()
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        addSubviews([resultLabel, textField, validateCPFbutton, generateCPFbutton])
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
            
            validateCPFbutton.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            validateCPFbutton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            validateCPFbutton.widthAnchor.constraint(equalToConstant: 200),
            
            generateCPFbutton.centerXAnchor.constraint(equalTo: validateCPFbutton.centerXAnchor),
            generateCPFbutton.topAnchor.constraint(equalTo: validateCPFbutton.bottomAnchor, constant: 30),
            generateCPFbutton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}

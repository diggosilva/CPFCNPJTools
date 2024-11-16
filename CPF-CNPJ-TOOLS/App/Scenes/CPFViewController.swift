//
//  ViewController.swift
//  CPF-CNPJ-TOOLS
//
//  Created by Diggo Silva on 16/11/24.
//

import UIKit

class CPFViewController: UIViewController {
    
    let cpfView = CPFView()
    
    override func loadView() {
        super.loadView()
        view = cpfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
    }
    
    private func setNavBar() {
        title = "Validador CPF"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

class CPFView: UIView {
    lazy var backgroundView: UIView = {
        let bgView = UIView()
        bgView.translatesAutoresizingMaskIntoConstraints = false
        bgView.backgroundColor = .white // Cor de fundo que você quiser
        bgView.layer.cornerRadius = 50 // Defina o valor do raio de arredondamento
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMaxYCorner] // Apenas os cantos superior esquerdo e inferior direito
        bgView.layer.shadowColor = UIColor.black.cgColor
        bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
        bgView.layer.shadowOpacity = 0.5 // default 0.0
        bgView.layer.shadowRadius = 5.0 // default 3.0
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
    
    lazy var createCPFbutton: UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Gerar CPF", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 8
        btn.backgroundColor = .systemIndigo
        return btn
    }()
    
    var cpfResult = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func cpfTextFieldMask() {
        // Remove todos os caracteres não numéricos
        var originalText = textField.text?.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Se o texto exceder 11 caracteres, limitamos a 11
        if originalText?.count ?? 0 > 11 {
            originalText = String(originalText?.prefix(11) ?? "")
        }
        
        // Inicializa o texto mascarado
        var maskedText = ""
        
        // Aplica a máscara
        if let unmaskedText = originalText {
            for (index, char) in unmaskedText.enumerated() {
                if index == 3 || index == 6 {
                    maskedText.append(".")
                } else if index == 9 {
                    maskedText.append("-")
                }
                maskedText.append(char)
            }
        }
        // Atualiza o texto do campo
        textField.text = maskedText
        cpfResult = maskedText
    }
    
    @objc private func validateCPF() {
        CPFValidator().validate(cpfResult)
    }
    
    private func setupView() {
        setHierarchy()
        setConstraints()
    }
    
    private func setHierarchy() {
        backgroundColor = #colorLiteral(red: 0.9594197869, green: 0.9599153399, blue: 0.975127399, alpha: 1)
        addSubviews([backgroundView, resultLabel, textField, validateCPFbutton, createCPFbutton])
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            backgroundView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 150),
            backgroundView.widthAnchor.constraint(equalToConstant: 300),
            
            resultLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            resultLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            
            textField.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 30),
            textField.centerXAnchor.constraint(equalTo: centerXAnchor),
            textField.widthAnchor.constraint(equalToConstant: 300),
            
            validateCPFbutton.centerXAnchor.constraint(equalTo: textField.centerXAnchor),
            validateCPFbutton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            validateCPFbutton.widthAnchor.constraint(equalToConstant: 200),
            
            createCPFbutton.centerXAnchor.constraint(equalTo: validateCPFbutton.centerXAnchor),
            createCPFbutton.topAnchor.constraint(equalTo: validateCPFbutton.bottomAnchor, constant: 30),
            createCPFbutton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}

class CPFValidator {
    func validate(_ cpf: String) -> Bool {
        // Limpa o CPF, removendo caracteres não numéricos
        let cleanedCPF = cpf.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        // Verifica se o CPF tem 11 dígitos
        guard cleanedCPF.count == 11, cleanedCPF.allSatisfy({ $0.isNumber }) else {
            print("DEBUG: CPF inválido.\nDEBUG: Deve ter 11 dígitos.")
            return false
        }
        
        // Verifica se todos os dígitos são iguais
        if Set(cleanedCPF).count == 1 {
            print("DEBUG: CPF inválido.\nDEBUG: Todos os dígitos são iguais.")
            return false
        }
        
        // Divide o CPF em 9 primeiros dígitos e os 2 últimos (dígitos verificadores)
        let cpfBaseDigits = cleanedCPF.prefix(9).compactMap({ Int(String($0)) })
        let providedCheckDigits = cleanedCPF.suffix(2).compactMap({ Int(String($0)) })
        
        // Calcula o primeiro dígito verificador
        let calculated1stCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: cpfBaseDigits, multiplyBy: 10)).truncatingRemainder(dividingBy: 11)
        let firstCheckDigit = calculated1stCheckDigit < 2 ? 0 : 11 - Int(calculated1stCheckDigit)
        
        // Calcula o segundo dígito verificador
        let calculated2ndCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: cpfBaseDigits + [firstCheckDigit], multiplyBy: 11)).truncatingRemainder(dividingBy: 11)
        let secondCheckDigit = calculated2ndCheckDigit < 2 ? 0 : 11 - Int(calculated2ndCheckDigit)
                
        // Compara os dígitos verificadores calculados com os fornecidos
        if firstCheckDigit == providedCheckDigits.first, secondCheckDigit == providedCheckDigits.last {
            print("DEBUG: CPF válido: \(formattedCPF(cleanedCPF))")
            return true
        } else {
            print("DEBUG: Número de CPF inválido.")
            return false
        }
    }
}

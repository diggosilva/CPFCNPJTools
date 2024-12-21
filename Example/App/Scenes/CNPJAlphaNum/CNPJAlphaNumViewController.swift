//
//  CNPJAlphaNumViewController.swift
//  ExampleApp
//
//  Created by Diggo Silva on 20/12/24.
//

import UIKit
import CPFCNPJTools

class CNPJAlphaNumViewController: UIViewController {

    let cnpjAlphaNumView = CNPJAlphaNumView()
    let cnpjAlphaNumManager = CNPJAlphaNumManager()
    
    override func loadView() {
        super.loadView()
        view = cnpjAlphaNumView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegatesAndDataSources()
    }
    
    private func setNavBar() {
        title = "CNPJ Alfanumérico"
    }
    
    private func setDelegatesAndDataSources() {
        cnpjAlphaNumView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension CNPJAlphaNumViewController: CNPJAlphaNumViewDelegate {
    func validateCNPJAlphaNum() {
        cnpjAlphaNumView.resultLabel.textColor = .label
        let cnpjAlphaNum = cnpjAlphaNumView.result.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        
        let cnpjAlphaNumResult = cnpjAlphaNumManager.validate(cnpjAlphaNum: cnpjAlphaNum)
        switch cnpjAlphaNumResult {
        case .valid: cnpjAlphaNumView.resultLabel.text = "CNPJ Alfanumérico válido."
        case .invalid: cnpjAlphaNumView.resultLabel.text = "Número de CNPJ Alfanumérico inválido."
        case .cnpjNull: cnpjAlphaNumView.resultLabel.text = "CNPJ Alfanumérico não pode ser nulo ou vazio."
        case .equalDigits: cnpjAlphaNumView.resultLabel.text = "CNPJ Alfanumérico inválido.\nTodos os dígitos são iguais."
        case .invalidFormat: cnpjAlphaNumView.resultLabel.text = "CNPJ Alfanumérico inválido.\nDeve ter 14 dígitos (apenas números e letras)."
        }
    }
    
    func generateCNPJAlphaNum() {
        cnpjAlphaNumView.textField.text = ""
        cnpjAlphaNumView.result = ""
        cnpjAlphaNumView.resultLabel.textColor = .systemTeal
        cnpjAlphaNumView.resultLabel.text = "Gerado CNPJ Alfanumérico Fictício:\n\(cnpjAlphaNumManager.generate())"
    }
}

//
//  CNPJAlphaNumViewController.swift
//  ExampleApp
//
//  Created by Diggo Silva on 15/12/24.
//

import UIKit
import CPFCNPJTools

class CNPJAlphaNumViewController: UIViewController {

    let cnpjAlphaNumView = CNPJAlphaNumView()
    
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
        let cnpj = cnpjAlphaNumView.CNPJAlphaNumResult.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        
        cnpjAlphaNumView.resultLabel.textColor = .label
                
        var cnpjAlphanumericStatus: CNPJAlphaNumStatus?
        
        if cnpj.isEmpty {
            cnpjAlphanumericStatus = .cnpjNull
        } else if cnpj.count != 14 {
            cnpjAlphanumericStatus = .invalidFormat
        } else if Set(cnpj).count == 1 {
            cnpjAlphanumericStatus = .equalDigits
        } else if !cnpj.isValidCnpjAlphaNum() {
            cnpjAlphanumericStatus = .invalid
        }
        if let status = cnpjAlphanumericStatus {
            switch status {
            case .cnpjNull: cnpjAlphaNumView.resultLabel.text = "CNPJ Alfanumérico não pode ser nulo ou vazio."
            case .invalidFormat: cnpjAlphaNumView.resultLabel.text = "CNPJ Alfanumérico inválido.\nDeve ter 14 dígitos (apenas números)."
            case .equalDigits: cnpjAlphaNumView.resultLabel.text = "CNPJ Alfanumérico inválido.\nTodos os dígitos são iguais."
            case .invalid: cnpjAlphaNumView.resultLabel.text = "Número de CNPJ Alfanumérico inválido."
            }
        } else {
            cnpjAlphaNumView.resultLabel.text = "CNPJ Alfanumérico \nválido."
        }
    }
    
    func generateCNPJAlphaNum() {
        cnpjAlphaNumView.textField.text = ""
        cnpjAlphaNumView.CNPJAlphaNumResult = ""
        cnpjAlphaNumView.resultLabel.textColor = .systemTeal
        let cnpjAlphaNum = String().generateFakeCnpjAlphaNum()
        cnpjAlphaNumView.resultLabel.text = "Gerado CNPJ Alfanumérico Fictício:\n\(cnpjAlphaNum)"
    }
}

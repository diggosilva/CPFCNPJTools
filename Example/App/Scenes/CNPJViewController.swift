//
//  CNPJViewController.swift
//  SampleApp
//
//  Created by Diggo Silva on 19/11/24.
//

import UIKit
import CPFCNPJTools

class CNPJViewController: UIViewController {
    
    let cnpjView = CNPJView()
    
    override func loadView() {
        super.loadView()
        view = cnpjView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegatesAndDataSources()
    }
    
    private func setNavBar() {
        title = "Validador CNPJ"
    }
    
    private func setDelegatesAndDataSources() {
        cnpjView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension CNPJViewController: CNPJViewDelegate {
    func validateCNPJ() {
        let cnpj = cnpjView.cnpjResult.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        cnpjView.resultLabel.textColor = .label
        
        var cnpjStatus: CNPJStatus?
        
        if cnpj.isEmpty {
            cnpjStatus = .cnpjNull
        } else if cnpj.count != 14 {
            cnpjStatus = .invalidFormat
        } else if Set(cnpj).count == 1 {
            cnpjStatus = .equalDigits
        } else if !cnpj.isValidCNPJ() {
            cnpjStatus = .invalid
        }
        if let status = cnpjStatus {
            switch status {
            case .cnpjNull: cnpjView.resultLabel.text = "CNPJ não pode ser nulo ou vazio."
            case .invalidFormat: cnpjView.resultLabel.text = "CNPJ inválido.\nDeve ter 14 dígitos (apenas números)."
            case .equalDigits: cnpjView.resultLabel.text = "CNPJ inválido.\nTodos os dígitos são iguais."
            case .invalid: cnpjView.resultLabel.text = "Número de CNPJ inválido."
            }
        } else {
            cnpjView.resultLabel.text = "CNPJ válido."
        }
    }
    
    func generateCNPJ() {
        cnpjView.textField.text = ""
        cnpjView.cnpjResult = ""
        cnpjView.resultLabel.textColor = .systemBrown
        let cnpj = String().generateFakeCNPJ()
        cnpjView.resultLabel.text = "Gerado CNPJ Fictício: \(cnpj)"
    }
}

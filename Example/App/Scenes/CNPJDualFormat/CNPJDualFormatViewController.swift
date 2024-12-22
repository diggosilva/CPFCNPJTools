//
//  CNPJDualFormatViewController.swift
//  ExampleApp
//
//  Created by Diggo Silva on 20/12/24.
//

import UIKit
import CPFCNPJTools

class CNPJDualFormatViewController: UIViewController {

    let cnpjDualFormatView = CNPJDualFormatView()
    let cnpjDualFormatManager = CNPJDualFormatManager()
    
    override func loadView() {
        super.loadView()
        view = cnpjDualFormatView
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
        cnpjDualFormatView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension CNPJDualFormatViewController: CNPJDualFormatViewDelegate {
    func validateCNPJDualFormat() {
        cnpjDualFormatView.resultLabel.textColor = .label
        let cnpjDualFormat = cnpjDualFormatView.result.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        
        let cnpjDualFormatResult = cnpjDualFormatManager.validate(cnpjDualFormat: cnpjDualFormat)
        switch cnpjDualFormatResult {
        case .valid: cnpjDualFormatView.resultLabel.text = "CNPJ Alfanumérico válido."
        case .invalid: cnpjDualFormatView.resultLabel.text = "Número de CNPJ Alfanumérico inválido."
        case .cnpjNull: cnpjDualFormatView.resultLabel.text = "CNPJ Alfanumérico não pode ser nulo ou vazio."
        case .equalDigits: cnpjDualFormatView.resultLabel.text = "CNPJ Alfanumérico inválido.\nTodos os dígitos são iguais."
        case .invalidFormat: cnpjDualFormatView.resultLabel.text = "CNPJ Alfanumérico inválido.\nDeve ter 14 dígitos (apenas números e letras)."
        }
    }
    
    func generateCNPJDualFormat() {
        cnpjDualFormatView.textField.text = ""
        cnpjDualFormatView.result = ""
        cnpjDualFormatView.resultLabel.textColor = .systemTeal
        cnpjDualFormatView.resultLabel.text = "Gerado CNPJ Alfanumérico Fictício:\n\(cnpjDualFormatManager.generate())"
    }
}

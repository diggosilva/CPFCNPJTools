//
//  ViewController.swift
//  CPF-CNPJ-TOOLS
//
//  Created by Diggo Silva on 16/11/24.
//

import UIKit
import CPFCNPJTools

class CPFViewController: UIViewController {
    
    let cpfView = CPFView()
    let cpfManager = CPFManager()
    
    override func loadView() {
        super.loadView()
        view = cpfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegatesAndDataSources()
    }
    
    private func setNavBar() {
        title = "Validador CPF"
    }
    
    private func setDelegatesAndDataSources() {
        cpfView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension CPFViewController: CPFViewDelegate {
    func validateCPF() {
        cpfView.resultLabel.textColor = .label
        let cpf = cpfView.result.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        let cpfResult = cpfManager.validate(cpf: cpf)
        switch cpfResult {
        case .valid: return cpfView.resultLabel.text = "CPF válido."
        case .invalid: return cpfView.resultLabel.text = "Número de CPF inválido."
        case .cpfNull: return cpfView.resultLabel.text = "CPF não pode ser nulo ou vazio."
        case .equalDigits: return cpfView.resultLabel.text = "CPF inválido.\nTodos os dígitos são iguais."
        case .invalidFormat: return cpfView.resultLabel.text = "CPF inválido.\nDeve ter 11 dígitos (apenas números)."
        }
    }
    
    func generateCPF() {
        cpfView.textField.text = ""
        cpfView.result = ""
        cpfView.resultLabel.textColor = .systemIndigo
        cpfView.resultLabel.text = "Gerado CPF Fictício: \(cpfManager.generateMasked() ?? "")"
    }
}

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
        let cpf = cpfView.cpfResult.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        cpfView.resultLabel.textColor = .label
        
        let cpfResult = CPFValidator().validate(cpf: cpf)
        switch cpfResult {
        case .valid: return cpfView.resultLabel.text = "CPF válido."
        case .cpfNull: return cpfView.resultLabel.text = "CPF não pode ser nulo ou vazio."
        case .invalidFormat: return cpfView.resultLabel.text = "CPF inválido.\nDeve ter 11 dígitos (apenas números)."
        case .equalDigits: return cpfView.resultLabel.text = "CPF inválido.\nTodos os dígitos são iguais."
        case .invalid: return cpfView.resultLabel.text = "Número de CPF inválido."
        }
    }
    
    func generateCPF() {
        cpfView.textField.text = ""
        cpfView.cpfResult = ""
        cpfView.resultLabel.textColor = .systemIndigo
        let cpf = CPFValidator().generateFakeCPFMasked()
        cpfView.resultLabel.text = "Gerado CPF Fictício: \(cpf ?? "")"
    }
}

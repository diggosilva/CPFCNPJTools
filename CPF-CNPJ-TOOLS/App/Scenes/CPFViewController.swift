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

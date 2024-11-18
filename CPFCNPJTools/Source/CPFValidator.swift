//
//  CPFValidator.swift
//  CPF-CNPJ-TOOLS
//
//  Created by Diggo Silva on 16/11/24.
//

import Foundation

public enum CPFStatus {
    case cpfNull       // CPF não pode ser nulo ou vazio.
    case invalidFormat // CPF inválido.\nCPF deve ter 11 dígitos (apenas números)
    case equalDigits   // CPF com números repetidos não é válido (ex: 111.111.111-11, que é inválido por ser um número repetido)
    case valid         // CPF válido
    case invalid       // CPF inválido
}

public class CPFValidator {
    
    public init() {}
    
    public func validate(cpf: String) -> CPFStatus {
        // Limpa o CPF, removendo caracteres não numéricos
        let cleanedCPF = cpf.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        guard cleanedCPF.count > 0 else {
            return .cpfNull
        }
        
        // Verifica se o CPF tem 11 dígitos
        guard cleanedCPF.count == 11, cleanedCPF.allSatisfy({ $0.isNumber }) else {
            return .invalidFormat
        }
        
        // Verifica se todos os dígitos são iguais
        if Set(cleanedCPF).count == 1 {
            return .equalDigits
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
//            print("DEBUG: CPF válido: \(formattedCPF(cleanedCPF))")
            return .valid
        } else {
//            print("DEBUG: Número de CPF inválido.")
            return .invalid
        }
    }
    
    public func generateCPF() -> String {
        var get9RandomNumbers = (0..<9).compactMap({ _ in Int.random(in: 0...9) })
        
        // Calcula o primeiro dígito verificador
        let calculated1stCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: get9RandomNumbers, multiplyBy: 10)).truncatingRemainder(dividingBy: 11)
        calculated1stCheckDigit < 2 ? get9RandomNumbers.append(0) : get9RandomNumbers.append(11 - Int(calculated1stCheckDigit))
        
        // Calcula o segundo dígito verificador
        let calculated2ndCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: get9RandomNumbers, multiplyBy: 11)).truncatingRemainder(dividingBy: 11)
        calculated2ndCheckDigit < 2 ? get9RandomNumbers.append(0) : get9RandomNumbers.append(11 - Int(calculated2ndCheckDigit))
        
        let generatedFakeCPF = get9RandomNumbers.map({ String($0) }).joined()
        print("DEBUG: Gerado CPF Fictício: \(formattedCPF(generatedFakeCPF))")
        return "\(formattedCPF(generatedFakeCPF))"
    }
    
    func formattedCPF(_ cpf: String) -> String {
        guard cpf.count == 11 else { return cpf }
        let formattedCPF = "\(cpf.prefix(3)).\(cpf.dropFirst(3).prefix(3)).\(cpf.dropFirst(6).prefix(3))-\(cpf.suffix(2))"
        return formattedCPF
    }
    
    func calculateCPFCheckSum(cpfBaseDigits: [Int], multiplyBy: Int) -> Int {
        var multiplyBy = multiplyBy
        var checkSum = 0
        
        for digit in cpfBaseDigits {
            checkSum += digit * multiplyBy
            multiplyBy -= 1
        }
        return checkSum
    }
    
    func animateLabelTextChange(label: UILabel, text: String, textColor: UIColor) {
        UIView.animate(withDuration: 0.5) {
            label.alpha = 0
        }
        UIView.animate(withDuration: 0.5) {
            label.alpha = 1
            label.text = text
            label.textColor = textColor
        }
    }
}

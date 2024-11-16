//
//  CPFValidator.swift
//  CPF-CNPJ-TOOLS
//
//  Created by Diggo Silva on 16/11/24.
//

import Foundation

enum CPFStatus {
    case valid // CPF válido
    case invalid // CPF inválido
    case invalidFormat // CPF com formato errado (ex: caracteres não numéricos ou número de dígitos incorretos)
    case equalDigits // CPF com todos os dígitos iguais (ex: 111.111.111-11, que é inválido por ser um número repetido)
    case checkFailed // CPF com falha nos cálculos dos dígitos verificadores
}

class CPFValidator {
    func validate(cpf: String) -> Bool {
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
    
    func generateCPF() -> Bool {
        var get9RandomNumbers = (0..<9).compactMap({ _ in Int.random(in: 0...9) })
        
        // Calcula o primeiro dígito verificador
        let calculated1stCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: get9RandomNumbers, multiplyBy: 10)).truncatingRemainder(dividingBy: 11)
        calculated1stCheckDigit < 2 ? get9RandomNumbers.append(0) : get9RandomNumbers.append(11 - Int(calculated1stCheckDigit))
        
        // Calcula o segundo dígito verificador
        let calculated2ndCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: get9RandomNumbers, multiplyBy: 11)).truncatingRemainder(dividingBy: 11)
        calculated2ndCheckDigit < 2 ? get9RandomNumbers.append(0) : get9RandomNumbers.append(11 - Int(calculated2ndCheckDigit))
        
        let generatedFakeCPF = get9RandomNumbers.map({ String($0) }).joined()
        print("DEBUG: Generado CPF Fictício: \(formattedCPF(generatedFakeCPF))")
        return true
    }
}

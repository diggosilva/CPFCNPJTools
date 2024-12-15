//
//  CNPJANValidator.swift
//  ExampleApp
//
//  Created by Diggo Silva on 15/12/24.
//

import Foundation

enum CNPJAlphaNumStatus {
    case invalidLength
    case allDigitsEqual
    case invalidCheckDigits
    case invalidFormat
}

extension String {
    func isValidCnpjAlphaNum() -> Bool {
        // Limpa o CNPJ, removendo caracteres não numéricos
        let cleanedCNPJ = self.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        
        // Verifica se o CNPJ tem 14 dígitos
        guard cleanedCNPJ.count == 14 else {
            print("DEBUG: CNPJ Alfanumérico inválido.\nDEBUG: Deve ter 14 dígitos.")
            return false
        }
        
        // Verifica se todos os dígitos são iguais
        if Set(cleanedCNPJ).count == 1 {
            print("DEBUG: CNPJ Alfanumérico inválido.\nDEBUG: Todos os dígitos são iguais.")
            return false
        }
        
        // Divide o CNPJ em 12 primeiros dígitos e os 2 últimos (dígitos verificadores)
        let cnpjBaseDigits = self.prefix(12).compactMap({ Int($0.asciiValue!) - 48 })
        let providedCheckDigits = self.suffix(2).compactMap({ Int(String($0)) })
                
        // Pesos para os 2 últimos dígitos
        let multiplyFirstBy = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        let multiplySecondBy = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        
        //MARK: Calcula 1º Dígito
        let calculated1stCheckDigit = Double(calculateCNPJAlphaNumCheckSum(cnpj12Digits: cnpjBaseDigits, multiplyBy: multiplyFirstBy)).truncatingRemainder(dividingBy: 11)
        let firstCheckDigit = calculated1stCheckDigit < 2 ? 0 : 11 - Int(calculated1stCheckDigit)
        
        //MARK: Calcula 2º Dígito
        let calculated2ndCheckDigit = Double(calculateCNPJAlphaNumCheckSum(cnpj12Digits: cnpjBaseDigits + [firstCheckDigit], multiplyBy: multiplySecondBy)).truncatingRemainder(dividingBy: 11)
        let secondCheckDigit = calculated2ndCheckDigit < 2 ? 0 : 11 - Int(calculated2ndCheckDigit)
        
        // Compara os dígitos verificadores calculados com os fornecidos
        if  firstCheckDigit == providedCheckDigits.first, secondCheckDigit == providedCheckDigits.last {
            return true
        } else {
            return false
        }
    }
    
    func generateCnpjAlphaNum() -> String {
        let get12RandomAlphaNumbers = (0..<12).compactMap({ _ in
            
            let isLetter = Bool.random()
            let randomValue: UInt8
            
            if isLetter {
                randomValue = UInt8.random(in: 65...90)
            } else {
                randomValue = UInt8.random(in: 48...57)
            }
            return Character(UnicodeScalar(randomValue))
        })
        
        var randomCNPJString = String(get12RandomAlphaNumbers)
        
        var cnpj12Digits: [Int] = []
        
        for char in randomCNPJString {
            if let asciiValue = char.asciiValue {
                let valueASCII = asciiValue - 48
                cnpj12Digits.append(Int(valueASCII))
            }
        }
        
        let multiplyFirstBy = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        let multiplySecondBy = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        
        //MARK: Calcula 1º Dígito
        let calculated1stCheckDigit = Double(calculateCNPJAlphaNumCheckSum(cnpj12Digits: cnpj12Digits, multiplyBy: multiplyFirstBy)).truncatingRemainder(dividingBy: 11)
        calculated1stCheckDigit < 2 ? cnpj12Digits.append(0) : cnpj12Digits.append(11 - Int(calculated1stCheckDigit))
        
        //MARK: Calcula 2º Dígito
        let calculated2ndCheckDigit = Double(calculateCNPJAlphaNumCheckSum(cnpj12Digits: cnpj12Digits, multiplyBy: multiplySecondBy)).truncatingRemainder(dividingBy: 11)
        calculated2ndCheckDigit < 2 ? cnpj12Digits.append(0) : cnpj12Digits.append(11 - Int(calculated2ndCheckDigit))
        
        let generatedFakeCNPJ = cnpj12Digits.map({ String($0) }).joined()
        randomCNPJString = randomCNPJString + String(generatedFakeCNPJ.suffix(2))
        return "Gerado CNPJ Alfanumérico Fictício:\n\(formattedCNPJAlphaNum(randomCNPJString))"
    }
    
    func calculateCNPJAlphaNumCheckSum(cnpj12Digits: [Int], multiplyBy: [Int]) -> Int {
        let result = zip(cnpj12Digits, multiplyBy).map({ $0 * $1 })
        return result.reduce(0, +)
    }
    
    func formattedCNPJAlphaNum(_ cnpj: String) -> String {
        guard cnpj.count == 14 else { return cnpj }
        let formatted = "\(cnpj.prefix(2)).\(cnpj.dropFirst(2).prefix(3)).\(cnpj.dropFirst(5).prefix(3))/\(cnpj.dropFirst(8).prefix(4))-\(cnpj.suffix(2))"
        return formatted
    }
}

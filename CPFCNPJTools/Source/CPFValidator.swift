//
//  CPFValidator.swift
//  CPF-CNPJ-TOOLS
//
//  Created by Diggo Silva on 16/11/24.
//

import Foundation

public enum CPFStatus {
    case cpfNull       // CPF cannot be null or empty.
    case invalidFormat // Invalid CPF.\nCPF must have 11 digits (only numbers).
    case equalDigits   // CPF with repeated digits is not valid (e.g., 111.111.111-11, which is invalid because it's a repeated number).
    case valid         // Valid CPF.
    case invalid       // Invalid CPF.
}

public class CPFValidator {
    
    public init() {}
    
    public func validate(cpf: String) -> CPFStatus {
        // Clears the CPF, removing non-numeric characters
        let cleanedCPF = cpf.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        guard cleanedCPF.count > 0 else { return .cpfNull }
        
        // Checks if the CPF has 11 digits
        guard cleanedCPF.count == 11, cleanedCPF.allSatisfy({ $0.isNumber }) else { return .invalidFormat }
        
        // Checks if all digits are the same
        if Set(cleanedCPF).count == 1 { return .equalDigits }
        
        // Divides the CPF into the first 9 digits and the last 2 (verification digits)
        let cpfBaseDigits = cleanedCPF.prefix(9).compactMap({ Int(String($0)) })
        let providedCheckDigits = cleanedCPF.suffix(2).compactMap({ Int(String($0)) })
        
        // Calculates the first verification digit
        let calculated1stCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: cpfBaseDigits, multiplyBy: 10)).truncatingRemainder(dividingBy: 11)
        let firstCheckDigit = calculated1stCheckDigit < 2 ? 0 : 11 - Int(calculated1stCheckDigit)
        
        // Calculates the second verification digit
        let calculated2ndCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: cpfBaseDigits + [firstCheckDigit], multiplyBy: 11)).truncatingRemainder(dividingBy: 11)
        let secondCheckDigit = calculated2ndCheckDigit < 2 ? 0 : 11 - Int(calculated2ndCheckDigit)
        
        // Compares the calculated verification digits with the provided ones
        if firstCheckDigit == providedCheckDigits.first, secondCheckDigit == providedCheckDigits.last {
            return .valid
        } else {
            return .invalid
        }
    }
    
    public func generateFakeCPF() -> String {
        var get9RandomNumbers = (0..<9).compactMap({ _ in Int.random(in: 0...9) })
        
        let calculated1stCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: get9RandomNumbers, multiplyBy: 10)).truncatingRemainder(dividingBy: 11)
        calculated1stCheckDigit < 2 ? get9RandomNumbers.append(0) : get9RandomNumbers.append(11 - Int(calculated1stCheckDigit))
        
        let calculated2ndCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: get9RandomNumbers, multiplyBy: 11)).truncatingRemainder(dividingBy: 11)
        calculated2ndCheckDigit < 2 ? get9RandomNumbers.append(0) : get9RandomNumbers.append(11 - Int(calculated2ndCheckDigit))
        
        let generatedFakeCPF = get9RandomNumbers.map({ String($0) }).joined()
        return formattedCPF(generatedFakeCPF)
    }
    
    func formattedCPF(_ cpf: String) -> String {
        guard cpf.count == 11 else { return cpf }
        let formattedCPF = "\(cpf.prefix(3)).\(cpf.dropFirst(3).prefix(3)).\(cpf.dropFirst(6).prefix(3))-\(cpf.suffix(2))"
        return formattedCPF
    }
    
    public func calculateCPFCheckSum(cpfBaseDigits: [Int], multiplyBy: Int) -> Int {
        var multiplyBy = multiplyBy
        var checkSum = 0
        
        for digit in cpfBaseDigits {
            checkSum += digit * multiplyBy
            multiplyBy -= 1
        }
        return checkSum
    }
    
    public func applyCPFMask(cpf: String) -> String {
        var originalText = cpf.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        if originalText.count > 11 {
            originalText = String(originalText.prefix(11))
        }
        var maskedText = ""
        
        for (index, char) in originalText.enumerated() {
            if index == 3 || index == 6 {
                maskedText.append(".")
            } else if index == 9 {
                maskedText.append("-")
            }
            maskedText.append(char)
        }
        return maskedText
    }
}

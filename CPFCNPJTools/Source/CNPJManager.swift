//
//  CNPJValidator.swift
//  CPFCNPJTools
//
//  Created by Diggo Silva on 19/11/24.
//

import Foundation

/// Enum representing the different statuses of a CNPJ after validation.
public enum CNPJStatus {
    case valid         // Valid CNPJ.
    case invalid       // Invalid CNPJ.
    case cnpjNull      // CNPJ cannot be null or empty.
    case equalDigits   // CNPJ with repeated digits is not valid.
    case invalidFormat // Invalid CNPJ. Must have 14 characters.
}

/// The `CNPJManager` class is responsible for validating, generating, and formatting CNPJ numbers.
public class CNPJManager {
    
    public init() {}
    
    public func validate(cnpj: String) -> CNPJStatus {
        let cleanedCNPJ = cnpj.uppercased().replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        
        guard !cleanedCNPJ.isEmpty else { return .cnpjNull }
        guard cleanedCNPJ.count == 14 else { return .invalidFormat }
        if Set(cleanedCNPJ).count == 1 { return .equalDigits }
        
        let allValues = cleanedCNPJ.compactMap({ Int($0.asciiValue ?? 48) - 48 })
        let cnpjBaseDigits = Array(allValues.prefix(12))
        let providedCheckDigits = Array(allValues.suffix(2))
        
        let multiplyFirstBy = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        let multiplySecondBy = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        
        let sum1 = calculatedCNPJCheckSum(cnpj12Digits: cnpjBaseDigits, multiplyBy: multiplyFirstBy)
        let firstCheckDigit = (sum1 % 11) < 2 ? 0 : 11 - (sum1 % 11)
        
        let sum2 = calculatedCNPJCheckSum(cnpj12Digits: cnpjBaseDigits + [firstCheckDigit], multiplyBy: multiplySecondBy)
        let secondCheckDigit = (sum2 % 11) < 2 ? 0 : 11 - (sum2 % 11)
        
        // DVs must be numeric
        let dvPart = cleanedCNPJ.suffix(2)
        guard dvPart.allSatisfy({ $0.isNumber }) else { return .invalid }
        
        if firstCheckDigit == providedCheckDigits.first, secondCheckDigit == providedCheckDigits.last {
            return .valid
        } else {
            return .invalid
        }
    }
    
    public func generate() -> String {
        // Generates traditional numeric CNPJ for this manager
        let randomBase = (0..<8).map({ _ in Int.random(in: 0...9) }) + [0, 0, 0, 1]
        var cnpjDigits = randomBase
        
        let multiplyFirstBy = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        let multiplySecondBy = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        
        let sum1 = calculatedCNPJCheckSum(cnpj12Digits: cnpjDigits, multiplyBy: multiplyFirstBy)
        let dv1 = (sum1 % 11) < 2 ? 0 : 11 - (sum1 % 11)
        cnpjDigits.append(dv1)
        
        let sum2 = calculatedCNPJCheckSum(cnpj12Digits: cnpjDigits, multiplyBy: multiplySecondBy)
        let dv2 = (sum2 % 11) < 2 ? 0 : 11 - (sum2 % 11)
        cnpjDigits.append(dv2)
        
        return cnpjDigits.map({ String($0) }).joined()
    }
    
    public func generateMasked() -> String? {
        return format(generate())
    }
    
    private func format(_ cnpj: String) -> String {
        guard cnpj.count == 14 else { return cnpj }
        return "\(cnpj.prefix(2)).\(cnpj.dropFirst(2).prefix(3)).\(cnpj.dropFirst(5).prefix(3))/\(cnpj.dropFirst(8).prefix(4))-\(cnpj.suffix(2))"
    }
    
    private func calculatedCNPJCheckSum(cnpj12Digits: [Int], multiplyBy: [Int]) -> Int {
        return zip(cnpj12Digits, multiplyBy).map({ $0 * $1 }).reduce(0, +)
    }
    
    public func mask(cnpj: String) -> String {
        var originalText = cnpj.uppercased().replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        if originalText.count > 14 { originalText = String(originalText.prefix(14)) }
        
        var maskedText = ""
        for (index, char) in originalText.enumerated() {
            if index == 2 || index == 5 { maskedText.append(".") }
            else if index == 8 { maskedText.append("/") }
            else if index == 12 { maskedText.append("-") }
            maskedText.append(char)
        }
        return maskedText
    }
}

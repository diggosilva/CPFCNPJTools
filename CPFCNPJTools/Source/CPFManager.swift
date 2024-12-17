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

/// The `CPFValidator` class is responsible for validating, generating, and formatting CPF numbers (Brazilian Individual Taxpayer Registry).
///
/// It provides methods to validate a CPF, generate fake CPFs, format a CPF into a readable format, and apply a mask to the CPF.
public class CPFManager {
    let string: String
    
    /// Inicializa um novo validador de CPF.
    public init(string: String) {
        self.string = string
    
    /// Validates a provided CPF, checking its format and verifying if the check digits are correct.
    /// - Parameter cpf: The CPF to be validated.
    /// - Returns: A `CPFStatus` value indicating the result of the validation.
    ///
    /// **Usage example:**
    /// ```swift
    /// let validator = CPFValidator()
    /// let result = validator.validate(cpf: "11144477735")
    /// print(result) // .valid or .invalid
    /// ```
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
    
    /// Generates a valid and random fake CPF.
    ///
    /// This method creates a random CPF, calculates the check digits, and returns a valid CPF.
    ///
    /// - Returns: A randomly generated valid fake CPF.
    ///
    /// **Usage example:**
    /// ```swift
    /// let validator = CPFValidator()
    /// let fakeCPF = validator.generateFakeCPF()
    /// print(fakeCPF) // "11144477735"
    /// ```
    public func generateFakeCPF() -> String {
        var get9RandomNumbers = (0..<9).compactMap({ _ in Int.random(in: 0...9) })
        
        let calculated1stCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: get9RandomNumbers, multiplyBy: 10)).truncatingRemainder(dividingBy: 11)
        calculated1stCheckDigit < 2 ? get9RandomNumbers.append(0) : get9RandomNumbers.append(11 - Int(calculated1stCheckDigit))
        
        let calculated2ndCheckDigit = Double(calculateCPFCheckSum(cpfBaseDigits: get9RandomNumbers, multiplyBy: 11)).truncatingRemainder(dividingBy: 11)
        calculated2ndCheckDigit < 2 ? get9RandomNumbers.append(0) : get9RandomNumbers.append(11 - Int(calculated2ndCheckDigit))
        
        let generatedFakeCPF = get9RandomNumbers.map({ String($0) }).joined()
        
        return validate(cpf: generatedFakeCPF) == .valid ? generatedFakeCPF : generateFakeCPF()
    }
    
    /// Generates a fake CPF with a mask (readable format).
    ///
    /// This method generates a fake CPF and applies the formatting in the "xxx.xxx.xxx-xx" pattern.
    ///
    /// - Returns: The generated fake CPF with the applied mask, or `nil` if the CPF cannot be generated.
    ///
    /// **Usage example:**
    /// ```swift
    /// let validator = CPFValidator()
    /// let fakeCPFMasked = validator.generateFakeCPFMasked()
    /// print(fakeCPFMasked) // "111.444.777-35"
    /// ```
    public func generateFakeCPFMasked() -> String? {
        return formattedCPF(generateFakeCPF())
    }
    
    /// Formats a CPF in the "xxx.xxx.xxx-xx" pattern.
    /// - Parameter cpf: The CPF to be formatted.
    /// - Returns: The formatted CPF, or `nil` if the CPF does not have exactly 11 digits.
    ///
    /// **Usage example:**
    /// ```swift
    /// let formatted = validator.formattedCPF("11144477735")
    /// print(formatted) // "111.444.777-35"
    /// ```
    public func formattedCPF(_ cpf: String) -> String? {
        guard cpf.count == 11 else { return nil }
        let formattedCPF = "\(cpf.prefix(3)).\(cpf.dropFirst(3).prefix(3)).\(cpf.dropFirst(6).prefix(3))-\(cpf.suffix(2))"
        return formattedCPF
    }
    
    /// Calculates the checksum of a base CPF, used to determine the check digits.
    ///
    /// - Parameters:
    ///   - cpfBaseDigits: The first 9 digits of the CPF.
    ///   - multiplyBy: The initial multiplication value (10 for the first digit, 11 for the second).
    /// - Returns: The calculated checksum value.
    ///
    /// **Usage example:**
    /// ```swift
    /// let checkSum = validator.calculateCPFCheckSum(cpfBaseDigits: [1, 1, 1, 4, 4, 4, 7, 7, 7], multiplyBy: 10)
    /// print(checkSum) // Result of the calculation
    /// ```
    public func calculateCPFCheckSum(cpfBaseDigits: [Int], multiplyBy: Int) -> Int {
        var multiplyBy = multiplyBy
        var checkSum = 0
        
        for digit in cpfBaseDigits {
            checkSum += digit * multiplyBy
            multiplyBy -= 1
        }
        return checkSum
    }
    
    /// Applies a mask to the CPF, transforming it into the "xxx.xxx.xxx-xx" format.
    ///
    /// - Parameter cpf: The CPF to be masked.
    /// - Returns: The CPF with the applied mask.
    ///
    /// **Usage example:**
    /// ```swift
    /// let maskedCPF = validator.applyMask(cpf: "11144477735")
    /// print(maskedCPF) // "111.444.777-35"
    /// ```
    public func applyMask(cpf: String) -> String {
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

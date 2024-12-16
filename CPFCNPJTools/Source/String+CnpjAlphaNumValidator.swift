//
//  CNPJANValidator.swift
//  ExampleApp
//
//  Created by Diggo Silva on 15/12/24.
//

import Foundation

//public enum CNPJAlphaNumStatus {
//    case invalidLength
//    case allDigitsEqual
//    case invalidCheckDigits
//    case invalidFormat
//}

public enum CNPJAlphaNumStatus {
    case cnpjNull      // CNPJ cannot be null or empty.
    case invalidFormat // Invalid CNPJ.\nCNPJ must have 14 digits (only numbers).
    case equalDigits   // CNPJ with repeated digits is not valid (e.g., 11.111.111/0001-11, which is invalid because it's a repeated number).
    case invalid       // Invalid CNPJ.
}

public
extension String {
    /// This method validates whether the provided CNPJ Alpha Numeric has the correct format by removing non-alphanumeric characters, checking if the CNPJ Alpha Numeric has 14 characters, and calculating the check digits.
    /// It supports CNPJs that may contain letters (A-Z) in addition to numbers, making it an alphanumeric validation.
    ///
    /// - Returns: `true` if the CNPJ Alpha Numeric is valid, `false` otherwise.
    ///
    /// **Usage Example:**
    /// ```swift
    /// let isValid = String().isValidCnpjAlphaNum()
    /// print(isValid) // Output: true or false depending on the validity of the CNPJ Alpha Numeric
    /// ```
    ///
    /// * Important: *
    /// This method removes any non-alphanumeric characters before validating the CNPJ. It validates CNPJs that may include letters (A-Z) in addition to digits (0-9).
    func isValidCnpjAlphaNum() -> Bool {
        // Clears the CPF, removing non-alphanumeric characters
        let cleanedCNPJ = self.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        
        guard cleanedCNPJ.count > 0 else {
            print("DEBUG: CNPJ não pode ser nulo ou vazio")
            return false
        }
        
        // Checks if the CPF has 14 digits
        guard cleanedCNPJ.count == 14 else {
            print("DEBUG: CNPJ Alfanumérico inválido.\nDEBUG: Deve ter 14 dígitos.")
            return false
        }
        
        // Checks if all digits are the same
        if Set(cleanedCNPJ).count == 1 {
            print("DEBUG: CNPJ Alfanumérico inválido.\nDEBUG: Todos os dígitos são iguais.")
            return false
        }
        
        // Divides the CNPJ into the first 12 digits and the last 2 (verification digits)
        let cnpjBaseDigits = cleanedCNPJ.prefix(12).compactMap({ Int($0.asciiValue!) - 48 })
        let providedCheckDigits = cleanedCNPJ.suffix(2).compactMap({ Int(String($0)) })
                
        // Weights for the last 2 digits
        let multiplyFirstBy = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        let multiplySecondBy = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        
        // Calculates the first verification digit
        let calculated1stCheckDigit = Double(calculateCNPJAlphaNumCheckSum(cnpj12Digits: cnpjBaseDigits, multiplyBy: multiplyFirstBy)).truncatingRemainder(dividingBy: 11)
        let firstCheckDigit = calculated1stCheckDigit < 2 ? 0 : 11 - Int(calculated1stCheckDigit)
        
        // Calculates the second verification digit
        let calculated2ndCheckDigit = Double(calculateCNPJAlphaNumCheckSum(cnpj12Digits: cnpjBaseDigits + [firstCheckDigit], multiplyBy: multiplySecondBy)).truncatingRemainder(dividingBy: 11)
        let secondCheckDigit = calculated2ndCheckDigit < 2 ? 0 : 11 - Int(calculated2ndCheckDigit)
        
        // Compares the calculated verification digits with the provided ones
        if  firstCheckDigit == providedCheckDigits.first, secondCheckDigit == providedCheckDigits.last {
            return true
        } else {
            return false
        }
    }
    
    /// Generates a valid and random fake CNPJ Alpha Numeric.
    ///
    /// This method creates a random CNPJ Alpha Numeric, calculates the check digits, and returns a valid CNPJ Alpha Numeric.
    ///
    /// - Returns: A randomly generated valid fake CNPJ Alpha Numeric.
    ///
    /// **Usage example:**
    /// ```swift
    /// let fakeCnpjAlphaNum = String().generateFakeCnpjAlphaNum()
    /// print(fakeCnpjAlphaNum) // "12ABC34501DE35"
    /// ```
    func generateFakeCnpjAlphaNum() -> String {
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
        return formattedCNPJAlphaNum(randomCNPJString) ?? ""
    }
    
    /// Formats a CNPJ Alpha Numeric in the "xx.xxx.xxx/xxxx-xx" pattern.
    ///
    /// - Parameter cnpj: The CNPJ Alpha Numeric to be formatted.
    /// - Returns: The formatted CNPJ Alpha Numeric, or `nil` if the CNPJ Alpha Numeric does not have exactly 14 digits.
    ///
    /// **Usage example:**
    /// ```swift
    /// let formatted = String().formattedCNPJAlphaNum("12ABC34501DE35")
    /// print(formatted) // "12.ABC.345/01DE-35"
    /// ```
    func formattedCNPJAlphaNum(_ cnpj: String) -> String? {
        guard cnpj.count == 14 else { return nil }
        let formatted = "\(cnpj.prefix(2)).\(cnpj.dropFirst(2).prefix(3)).\(cnpj.dropFirst(5).prefix(3))/\(cnpj.dropFirst(8).prefix(4))-\(cnpj.suffix(2))"
        return formatted
    }
    
    /// Calculates the checksum of a base CNPJ Alpha Numeric, used to determine the check digits.
    ///
    /// - Parameters:
    ///   - cnpj12Digits: The first 12 digits of the CNPJ Alpha Numeric.
    ///   - multiplyBy: An array of multipliers for the checksum calculation.
    /// - Returns: The calculated checksum value.
    ///
    /// **Usage example:**
    /// ```swift
    /// let checkSum = String().calculateCNPJAlphaNumCheckSum(cnpj12Digits: [1, 2, A, B, C, 3, 4, 5, 0, 1, D, E], multiplyBy: [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2])
    /// print(checkSum) // Result of the calculation
    /// ```
    func calculateCNPJAlphaNumCheckSum(cnpj12Digits: [Int], multiplyBy: [Int]) -> Int {
        let result = zip(cnpj12Digits, multiplyBy).map({ $0 * $1 })
        return result.reduce(0, +)
    }
    
    /// Applies a mask to the CNPJ, transforming it into the "xx.xxx.xxx/xxxx-xx" format.
    ///
    /// - Parameter cnpjAlphaNum: The CNPJ Alpha Numeric to be masked.
    /// - Returns: The CNPJ Alpha Numeric with the applied mask.
    ///
    /// **Usage example:**
    /// ```swift
    /// let maskedCNPJAlphaNum = String().applyMask(cnpjAlphaNum: "12ABC34501DE35")
    /// print(maskedCNPJAlphaNum) // "12.ABC.345/01DE-35"
    /// ```
    func applyMask(cnpjAlphaNum: String) -> String {
        var originalText = cnpjAlphaNum.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        
        if originalText.count > 14 {
            originalText = String(originalText.prefix(14))
        }
        
        var maskedText = ""
        
        for (index, char) in originalText.enumerated() {
            if index == 2 || index == 5 {
                maskedText.append(".")
            } else if index == 8 {
                maskedText.append("/")
            } else if index == 12 {
                maskedText.append("-")
            }
            maskedText.append(char)
        }
        return maskedText
    }
}

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
    case equalDigits   // CNPJ with repeated digits is not valid (e.g., 11.111.111/1111-11, which is invalid because it's a repeated number).
    case invalidFormat // Invalid CNPJ.\nCNPJ must have 14 digits (only numbers).
}

/// The `CNPJManager` class is responsible for validating, generating, and formatting CNPJ numbers (Brazilian National Registry of Legal Entities).
///
/// It provides methods to validate a CNPJ, generate fake CNPJs, format a CNPJ into a readable format, and apply a mask to the CNPJ.
public class CNPJManager {
    
    public init() {}
    
    /// Validates a given CNPJ, checking if it is valid, properly formatted, and if the verification digits are correct.
    ///
    /// - Parameter cnpj: The CNPJ to be validated. It may contain non-numeric characters (dots, slashes, hyphens, etc.).
    /// - Returns: A `CNPJStatus` value indicating the validation status.
    ///
    /// The `CNPJStatus` enum can have the following values:
    /// - `.valid`: Indicates the CNPJ is valid.
    /// - `.invalid`: Indicates the CNPJ is invalid.
    /// - `.cnpjNull`: Indicates the CNPJ is empty.
    /// - `.invalidFormat`: Indicates the CNPJ has an invalid format (wrong number of digits, contains letters, etc.).
    /// - `.equalDigits`: Indicates the CNPJ contains the same digit repeated (e.g., "111.111.111/0001-11").
    ///
    /// **Example:**
    /// ```swift
    /// let cnpjManager = CNPJManager()
    /// let status = cnpjManager.validate(cnpj: "11.444.777/0001-61")
    /// print(status)  // .valid or .invalid
    /// ```
    public func validate(cnpj: String) -> CNPJStatus {
        // Clears the CNPJ, removing non-numeric characters
        let clearedCNPJ = cnpj.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        guard clearedCNPJ.count > 0 else { return .cnpjNull }
        
        // Checks if the CNPJ has 14 digits
        guard clearedCNPJ.count == 14, clearedCNPJ.allSatisfy({ $0.isNumber }) else { return .invalidFormat }
        
        // Checks if all digits are the same
        if Set(clearedCNPJ).count == 1 { return .equalDigits }
        
        // Divides the CNPJ into the first 12 digits and the last 2 (verification digits)
        let cnpjBaseDigits = clearedCNPJ.prefix(12).compactMap({ Int(String($0)) })
        let providedCheckDigits = clearedCNPJ.suffix(2).compactMap({ Int(String($0)) })
        
        let multiplyFirstBy = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        let multiplySecondBy = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        
        // Calculates the first verification digit
        let calculated1stCheckDigit = Double(calculatedCNPJCheckSum(cnpj12Digits: cnpjBaseDigits, multiplyBy: multiplyFirstBy)).truncatingRemainder(dividingBy: 11)
        let firstCheckDigit = calculated1stCheckDigit < 2 ? 0 : 11 - Int(calculated1stCheckDigit)
        
        // Calculates the second verification digit
        let calculated2ndCheckDigit = Double(calculatedCNPJCheckSum(cnpj12Digits: cnpjBaseDigits + [firstCheckDigit], multiplyBy: multiplySecondBy)).truncatingRemainder(dividingBy: 11)
        let secondCheckDigit = calculated2ndCheckDigit < 2 ? 0 : 11 - Int(calculated2ndCheckDigit)
        
        // Compares the calculated verification digits with the provided ones
        if firstCheckDigit == providedCheckDigits.first, secondCheckDigit == providedCheckDigits.last {
            return .valid
        } else {
            return .invalid
        }
    }
    
    private func generate() -> String {
        let get8RandomNumbers = (0..<8).compactMap({ _ in Int.random(in: 0...9) }) + [0, 0, 0, 1]
        
        var cnpj12Digits = get8RandomNumbers.compactMap({ Int(String($0)) })
        let multiplyFirstBy = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        let multiplySecondBy = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        
        let calculated1stCheckDigit = Double(calculatedCNPJCheckSum(cnpj12Digits: cnpj12Digits, multiplyBy: multiplyFirstBy)).truncatingRemainder(dividingBy: 11)
        calculated1stCheckDigit < 2 ? cnpj12Digits.append(0) : cnpj12Digits.append(11 - Int(calculated1stCheckDigit))
        
        let calculated2ndCheckDigit = Double(calculatedCNPJCheckSum(cnpj12Digits: cnpj12Digits, multiplyBy: multiplySecondBy)).truncatingRemainder(dividingBy: 11)
        calculated2ndCheckDigit < 2 ? cnpj12Digits.append(0) : cnpj12Digits.append(11 - Int(calculated2ndCheckDigit))
        
        let generatedFakeCNPJ = cnpj12Digits.compactMap({ String($0) }).joined()
        return validate(cnpj: generatedFakeCNPJ) == .valid ? generatedFakeCNPJ : generate()
    }
    
    /// Generates a random valid CNPJ and returns it already formatted with the mask (XX.XXX.XXX/XXXX-XX).
    ///
    /// - Returns: The generated CNPJ formatted with the mask.
    ///
    /// - Warning: The CNPJ generated by this method is **valid** (based on CNPJ validation rules), but **it is not a real CNPJ**.
    ///   It does not correspond to a real company and should **not be used for any fraudulent, illegal, or deceptive purposes**.
    ///   This method is intended solely for **testing or simulation purposes** in development and software testing environments.
    ///
    /// **Example:**
    /// ```swift
    /// let cnpjManager = CNPJManager()
    /// let fakeCNPJMasked = cnpjManager.generateMasked()
    /// print(fakeCNPJMasked)  // "11.444.777/0001-61"
    /// ```
    public func generateMasked() -> String? {
        return format(generate())
    }
    
    private func format(_ cnpj: String) -> String {
        guard cnpj.count == 14 else { return cnpj }
        let formattedCNPJ = "\(cnpj.prefix(2)).\(cnpj.dropFirst(2).prefix(3)).\(cnpj.dropFirst(5).prefix(3))/\(cnpj.dropFirst(8).prefix(4))-\(cnpj.suffix(2))"
        return formattedCNPJ
    }
    
    private func calculatedCNPJCheckSum(cnpj12Digits: [Int], multiplyBy: [Int]) -> Int {
        let result = zip(cnpj12Digits, multiplyBy).map({ $0 * $1 })
        return result.reduce(0, +)
    }
 
    /// Masks a given CNPJ by adding typical separators `XX.XXX.XXX/XXXX-XX`.
    ///
    /// - Parameter cnpj: The CNPJ to be masked. It may contain non-numeric characters.
    /// - Returns: The CNPJ masked in the format `XX.XXX.XXX/XXXX-XX`.
    ///
    /// - **Note**:
    /// This method can be used in a `UITextField`'s delegate to format the CNPJ input while the user types.
    ///
    /// - **Example**:
    /// ```swift
    /// let cnpjManager = CNPJManager()
    /// let maskedCnpj = cnpjManager.mask(cnpj: "11444777000161")
    /// print(maskedCnpj)  // "11.444.777/0001-61"
    /// ```
    /// **Usage in UITextField Delegate**:
    ///
    /// - Tip: In your `UITextField` delegate, you can use this method to format the CNPJ input as follows:
    ///
    /// ```swift
    /// func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    ///     guard let currentText = textField.text else { return true }
    ///     let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
    ///     textField.text = cnpjManager.mask(cnpj: newText)
    ///     return false // Prevent the default text change, as we are setting it manually
    /// }
    /// ```
    public func mask(cnpj: String) -> String {
        var originalText = cnpj.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
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

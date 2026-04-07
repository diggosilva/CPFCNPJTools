//
//  CNPJANValidator.swift
//  ExampleApp
//
//  Created by Diggo Silva on 15/12/24.
//

import Foundation

/// Enum representing the different statuses of a CNPJ Alphanumeric after validation.
public enum CNPJDualFormatStatus {
    case valid         // Valid CNPJ Alphanumeric.
    case invalid       // Invalid CNPJ Alphanumeric.
    case cnpjNull      // CNPJ Alphanumeric cannot be null or empty.
    case equalDigits   // CNPJ Alphanumeric with repeated digits is not valid (e.g., 11.111.111/1111-11, which is invalid because it's a repeated number).
    case invalidFormat // Invalid CNPJ.\nCNPJ Alphanumeric must have 14 digits (only numbers and letters).
}

/// The `CNPJDualFormatManager` class is responsible for validating, generating, and formatting CNPJ Alphanumeric (Brazilian National Registry of Legal Entities).
///
/// It provides methods to validate a CNPJ Alphanumeric, generate fake CNPJ Alphanumeric, format a CNPJ Alphanumeric into a readable format, and apply a mask to the CNPJ Alphanumeric.
public class CNPJDualFormatManager {

    public init() {}
    
    /// Validates a given CNPJ Alphanumeric, checking if it is valid, properly formatted, and if the verification digits are correct.
    ///
    /// - Parameter cnpjDualFormat: The CNPJ Alphanumeric to be validated. It may contain non-numeric characters (dots, slashes, hyphens, etc.).
    /// - Returns: A `CNPJAlphaNumStatus` value indicating the validation status.
    ///
    /// The `CNPJStatus` enum can have the following values:
    /// - `.valid`: Indicates the CNPJ Alphanumeric is valid.
    /// - `.invalid`: Indicates the CNPJ Alphanumeric is invalid.
    /// - `.cnpjNull`: Indicates the CNPJ Alphanumeric is empty.
    /// - `.invalidFormat`: Indicates the CNPJ Alphanumeric has an invalid format (wrong number of digits, contains letters, etc.).
    /// - `.equalDigits`: Indicates the CNPJ Alphanumeric contains the same digit repeated (e.g., "111.111.111/1111-11").
    ///
    /// **Example:**
    /// ```swift
    /// let cnpjDualFormatManager = CNPJDualFormatManager()
    /// let status = cnpjDualFormatManager.validate(cnpjDualFormat: "12.ABC.345/01DE-35")
    /// print(status)  // .valid or .invalid
    /// ```
    /// * Important: *
    /// This method removes any non-alphanumeric characters before validating the CNPJ Alphanumeric. It validates CNPJs that may include letters (A-Z) in addition to digits (0-9).
    public func validate(cnpjDualFormat: String) -> CNPJDualFormatStatus {
        // Clears the CNPJ, removing non-alphanumeric characters and forcing uppercase
        let cleanedCNPJ = cnpjDualFormat.uppercased().replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        
        guard !cleanedCNPJ.isEmpty else { return .cnpjNull }
        
        // Checks if the CNPJ has 14 characters
        guard cleanedCNPJ.count == 14 else { return .invalidFormat }
        
        // Checks if all characters are the same
        if Set(cleanedCNPJ).count == 1 { return .equalDigits }
        
        // Divides the CNPJ into the first 12 characters and the last 2 (verification digits)
        // Rule 2026: All characters (including DVs) follow Value = ASCII - 48
        let allValues = cleanedCNPJ.compactMap({ Int($0.asciiValue ?? 48) - 48 })
        let cnpjBaseDigits = Array(allValues.prefix(12))
        let providedCheckDigits = Array(allValues.suffix(2))
                
        // Weights for the last 2 digits
        let multiplyFirstBy = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        let multiplySecondBy = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        
        // Calculates the first verification digit
        let sum1 = calculateCNPJAlphaNumCheckSum(cnpj12Digits: cnpjBaseDigits, multiplyBy: multiplyFirstBy)
        let firstCheckDigit = (sum1 % 11) < 2 ? 0 : 11 - (sum1 % 11)
        
        // Calculates the second verification digit
        let sum2 = calculateCNPJAlphaNumCheckSum(cnpj12Digits: cnpjBaseDigits + [firstCheckDigit], multiplyBy: multiplySecondBy)
        let secondCheckDigit = (sum2 % 11) < 2 ? 0 : 11 - (sum2 % 11)
        
        // Final check: DVs provided must be numeric characters only (0-9)
        let dvPart = cleanedCNPJ.suffix(2)
        guard dvPart.allSatisfy({ $0.isNumber }) else { return .invalid }
        
        // Compares the calculated verification digits with the provided ones
        if firstCheckDigit == providedCheckDigits.first, secondCheckDigit == providedCheckDigits.last {
            return .valid
        } else {
            return .invalid
        }
    }
    
    /// Generates a random valid CNPJ Alphanumeric, without formatting.
    public func generate() -> String {
        let allowedChars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        let randomBaseChars = (0..<12).map { _ in allowedChars.randomElement()! }
        let randomBaseString = String(randomBaseChars)
        
        let cnpj12Digits = randomBaseChars.compactMap({ Int($0.asciiValue ?? 48) - 48 })
        
        let multiplyFirstBy = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        let multiplySecondBy = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2]
        
        let sum1 = calculateCNPJAlphaNumCheckSum(cnpj12Digits: cnpj12Digits, multiplyBy: multiplyFirstBy)
        let firstCheckDigit = (sum1 % 11) < 2 ? 0 : 11 - (sum1 % 11)
        
        let sum2 = calculateCNPJAlphaNumCheckSum(cnpj12Digits: cnpj12Digits + [firstCheckDigit], multiplyBy: multiplySecondBy)
        let secondCheckDigit = (sum2 % 11) < 2 ? 0 : 11 - (sum2 % 11)
        
        // Important: Append DVs as String literals to avoid Int-to-String length issues
        let finalCNPJ = randomBaseString + "\(firstCheckDigit)\(secondCheckDigit)"
        return format(finalCNPJ) ?? ""
    }
    
    private func format(_ cnpjDualFormat: String) -> String? {
        guard cnpjDualFormat.count == 14 else { return nil }
        let formatted = "\(cnpjDualFormat.prefix(2)).\(cnpjDualFormat.dropFirst(2).prefix(3)).\(cnpjDualFormat.dropFirst(5).prefix(3))/\(cnpjDualFormat.dropFirst(8).prefix(4))-\(cnpjDualFormat.suffix(2))"
        return formatted
    }
    
    private func calculateCNPJAlphaNumCheckSum(cnpj12Digits: [Int], multiplyBy: [Int]) -> Int {
        return zip(cnpj12Digits, multiplyBy).map({ $0 * $1 }).reduce(0, +)
    }
    
    public func mask(cnpjDualFormat: String) -> String {
        var originalText = cnpjDualFormat.uppercased().replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
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
    
    public func isCNPJAlphanumeric(_ cnpj: String) -> Bool {
        let cnpjClean = cnpj.uppercased().replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        return !cnpjClean.allSatisfy({ $0.isNumber })
    }
}

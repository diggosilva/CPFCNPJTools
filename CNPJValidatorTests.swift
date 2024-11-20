//
//  CNPJValidatorTests.swift
//  CPFCNPJTools-Unit-Tests
//
//  Created by Diggo Silva on 20/11/24.
//

import XCTest
import CPFCNPJTools

class CNPJValidatorTests: XCTestCase {
    
    override class func setUp() {
        super .setUp()
    }
    
    func testValidateWhenTheCNPJIsNilOrEmpty() {
        let sut = CNPJValidator()
        let validCNPJ = ""
        let result = sut.validate(cnpj: validCNPJ)
        XCTAssertEqual(result, .cnpjNull)
    }
    
    func testValidateWhenTheCNPJIsInvalidFormatWith12Characters() {
        let sut = CNPJValidator()
        let invalidCNPJ = "123456780001"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJIsEqualDigitsWith11Characters() {
        let sut = CNPJValidator()
        let invalidCNPJ = "11111111111111"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .equalDigits)
    }
    
    func testValidateWhenTheCNPJIsValid() {
        let sut = CNPJValidator()
        let validCNPJ = "44024904000122"
        let result = sut.validate(cnpj: validCNPJ)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenTheCNPJIsInvalidWith14Characters() {
        let sut = CNPJValidator()
        let invalidCNPJ = "12345678000190"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .invalid)
    }
    
    func testValidateWhenCNPJFakeIsGenerated() {
        let sut = CNPJValidator()
        let result = sut.generateCNPJ()
        XCTAssertFalse(result.isEmpty, "O CNPJ gerado não deve ser vazio")
        
        let regex = try! NSRegularExpression(pattern: "^\\d{2}\\.\\d{3}\\.\\d{3}\\/\\d{4}\\-\\d{2}$")
        let range = NSRange(location: 0, length: result.utf16.count)
        let match = regex.firstMatch(in: result, options: [], range: range)
        XCTAssertNotNil(match, "O CNPJ gerado não tem o formato correto")
    }
    
    func testValidateWhenCNPJIsMasked() {
        let sut = CNPJValidator()
        let unmaskedCNPJ = "12345678000190"
        let expectedMaskedCNPJ = "12.345.678/0001-90"
        let result = sut.applyCNPJMask(cnpj: unmaskedCNPJ)
        XCTAssertEqual(result, expectedMaskedCNPJ)
    }
    
    override class func tearDown() {
        super .tearDown()
    }
}

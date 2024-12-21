//
//  CNPJAlphaNumTests.swift
//  CPFCNPJTools-Unit-Tests
//
//  Created by Diggo Silva on 16/12/24.
//

import XCTest
import CPFCNPJTools

class CNPJAlphaNumTests: XCTestCase {
    let sut = CNPJAlphaNumManager()
    
    override class func setUp() {
        super.setUp()
    }
    
    func testValidateWhenTheCNPJAlphaNumIsNilOrEmpty() {
        let cnpjAlphaNum = ""
        let result = sut.validate(cnpjAlphaNum: cnpjAlphaNum)
        XCTAssertEqual(result, .cnpjNull)
    }
    
    func testValidateWhenTheCNPJAlphaNumIsInvalidFormatWithLessThan14Characters() {
        let invalidCNPJAlphaNum = "12ABC34501DE3"
        let result = sut.validate(cnpjAlphaNum: invalidCNPJAlphaNum)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJAlphaNumIsInvalidFormatWithMoreThan14Characters() {
        let invalidCNPJAlphaNum = "12ABC34501DE350"
        let result = sut.validate(cnpjAlphaNum: invalidCNPJAlphaNum)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJAlphaNumIsEqualDigitsWith14Characters() {
        let invalidCNPJAlphaNum = "XXXXXXXXXXXXXX"
        let result = sut.validate(cnpjAlphaNum: invalidCNPJAlphaNum)
        XCTAssertEqual(result, .equalDigits)
    }
    
    func testWhenTheCNPJAlphaNumIsValid() {
        let validCNPJAlphaNum = "12ABC34501DE35"
        let result = sut.validate(cnpjAlphaNum: validCNPJAlphaNum)
        XCTAssertEqual(result, .valid)
    }
    
    func testWhenTheCNPJAlphaNumIsInvalidWith14Characters() {
        let invalidCNPJAlphaNum = "12ABC34501DE30"
        let result = sut.validate(cnpjAlphaNum: invalidCNPJAlphaNum)
        XCTAssertEqual(result, .invalid)
    }
    
    func testValidateWhenTheCNPJAlphaNumHasNonAlphaNumericCharacters() {
        let cnpjAlphaNumWithSpecialChars = "12.BC.3#$/01DE-35"
        let result = sut.validate(cnpjAlphaNum: cnpjAlphaNumWithSpecialChars)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJAlphaNumHasSpaces() {
        let cnpjAlphaNumWithSpaces = "  12 ABC 345 / 01DE - 35 "
        let result = sut.validate(cnpjAlphaNum: cnpjAlphaNumWithSpaces)
        XCTAssertEqual(result, .valid)
    }
    
    func testGeneratedFakeCNPJAlphaNumMasked() {
        let fakeCNPJAlphaNumMasked = sut.generate()
        let result = sut.validate(cnpjAlphaNum: fakeCNPJAlphaNumMasked)
        XCTAssertNotNil(result)
        
        let cnpjAlphaNumClean = fakeCNPJAlphaNumMasked.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        let fakeCNPJMasked = sut.mask(cnpjAlphaNum: cnpjAlphaNumClean)
        XCTAssertEqual(fakeCNPJAlphaNumMasked, fakeCNPJMasked)
    }
        
    func testGeneratedFakeCNPJAlphaNum() {
        let fakeCNPJAlphaNum = sut.generate()
        let result = sut.validate(cnpjAlphaNum: fakeCNPJAlphaNum)
        let fakeCNPJAlphaNumClean = fakeCNPJAlphaNum.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        XCTAssertEqual(result, .valid)
        XCTAssertTrue(fakeCNPJAlphaNumClean.count == 14)
    }
    
    func testApplyCNPJAlphaNumMask() {
        let unmaskedCNPJAlphaNum = "12ABC34501DE35"
        let expectedMaskedCNPJAlphaNum = "12.ABC.345/01DE-35"
        let result = sut.mask(cnpjAlphaNum: unmaskedCNPJAlphaNum)
        XCTAssertEqual(result, expectedMaskedCNPJAlphaNum)
    }
    
    func testApplyCNPJAlphaNumMaskLessThan14Digits() {
        let unmaskedCNPJAlphaNum = "12ABC34501DE3"
        let expectedMaskedCNPJAlphaNum = "12.ABC.345/01DE-3"
        let result = sut.mask(cnpjAlphaNum: unmaskedCNPJAlphaNum)
        XCTAssertEqual(result, expectedMaskedCNPJAlphaNum)
    }
    
    func testApplyCNPJAlphaNumMaskMoreThan14Digits() {
        let unmaskedCNPJAlphaNum = "12ABC34501DE350"
        let expectedMaskedCNPJAlphaNum = "12.ABC.345/01DE-35"
        let result = sut.mask(cnpjAlphaNum: unmaskedCNPJAlphaNum)
        XCTAssertEqual(result, expectedMaskedCNPJAlphaNum)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}

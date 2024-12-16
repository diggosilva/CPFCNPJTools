//
//  CNPJAlphaNumTests.swift
//  CPFCNPJTools-Unit-Tests
//
//  Created by Diggo Silva on 16/12/24.
//

import XCTest
import CPFCNPJTools

class CNPJAlphaNumTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
    }
    
    func testValidateWhenTheCNPJAlphaNumIsNilOrEmpty() {
        let cnpjAlphaNum = ""
        let result = cnpjAlphaNum.isValidCnpjAlphaNum()
        XCTAssertFalse(result, "O CNPJ Alfanumérico vazio deveria retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJAlphaNumIsInvalidFormatWithLessThan14Characters() {
        let invalidCNPJAlphaNum = "12ABC34501DE3"
        let result = invalidCNPJAlphaNum.isValidCnpjAlphaNum()
        XCTAssertFalse(result, "O CNPJ Alfanumérico com menos de 14 caracteres deve retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJAlphaNumIsInvalidFormatWithMoreThan14Characters() {
        let invalidCNPJAlphaNum = "12ABC34501DE350"
        let result = invalidCNPJAlphaNum.isValidCnpjAlphaNum()
        XCTAssertFalse(result, "O CNPJ Alfanumérico com mais de 14 caracteres deve retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJAlphaNumIsEqualDigitsWith14Characters() {
        let invalidCNPJAlphaNum = "XXXXXXXXXXXXXX"
        let result = invalidCNPJAlphaNum.isValidCnpjAlphaNum()
        XCTAssertFalse(result, "O CNPJ Alfanumérico com todos os dígitos iguais deveria retornar false, mas retornou \(result)")
    }
    
    func testWhenTheCNPJAlphaNumIsValid() {
        let validCNPJAlphaNum = "12ABC34501DE35"
        let result = validCNPJAlphaNum.isValidCnpjAlphaNum()
        XCTAssertTrue(result, "O CNPJ Alfanumérico válido deve retornar true, mas retornou \(result)")
    }
    
    func testWhenTheCNPJAlphaNumIsInvalidWith14Characters() {
        let invalidCNPJAlphaNum = "12ABC34501DE30"
        let result = invalidCNPJAlphaNum.isValidCnpjAlphaNum()
        XCTAssertFalse(result, "O CNPJ Alfanumérico válido deve retornar true, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJAlphaNumHasNonAlphaNumericCharacters() {
        let cnpjAlphaNumWithSpecialChars = "12.ABC.345/01DE-35" // CNPJ Alfanumérico com pontuação
        let result = cnpjAlphaNumWithSpecialChars.isValidCnpjAlphaNum()
        XCTAssertTrue(result, "O CNPJ Alfanumérico com caracteres especiais (pontuação) deveria ser válido, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJAlphaNumHasSpacesOrSpecialChars() {
        let cnpjAlphaNumWithSpaces = "  12 ABC 345 / 01DE - 35 " // CNPJ com espaços extras
        let result = cnpjAlphaNumWithSpaces.isValidCnpjAlphaNum()
        XCTAssertTrue(result, "O CNPJ com espaços extras ou caracteres especiais deveria ser válido, mas retornou \(result)")
    }
    
    func testGeneratedFakeCNPJAlphaNumMasked() {
        let fakeCNPJAlphaNumMasked = String().generateFakeCnpjAlphaNum()
        let result = fakeCNPJAlphaNumMasked.isValidCnpjAlphaNum()
        XCTAssertTrue(result, "O CNPJ Alfanumérico gerado deve ser válido, mas retornou \(result)")
        
        let fakeCNPJMasked = String().applyMask(cnpjAlphaNum: fakeCNPJAlphaNumMasked)
        XCTAssertNotNil(fakeCNPJMasked, "O CNPJ Alfanumérico gerado não tem o formato correto")
    }
        
    func testGeneratedFakeCNPJ() {
        let fakeCNPJAlphaNum = String().generateFakeCnpjAlphaNum()
        let result = fakeCNPJAlphaNum.isValidCnpjAlphaNum()
        let fakeCNPJAlphaNumClean = fakeCNPJAlphaNum.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        XCTAssertTrue(result, "O CNPJ Alfanumérico gerado deve ser válido, mas retornou \(result)")
        XCTAssertTrue(fakeCNPJAlphaNumClean.count == 14)
    }
    
    func testApplyCNPJAlphaNumMask() {
        let unmaskedCNPJAlphaNum = "12ABC34501DE35"
        let expectedMaskedCNPJAlphaNum = "12.ABC.345/01DE-35"
        let result = String().applyMask(cnpjAlphaNum: unmaskedCNPJAlphaNum)
        XCTAssertEqual(result, expectedMaskedCNPJAlphaNum)
    }
    
    func testApplyCNPJAlphaNumMaskLessThan14Digits() {
        let unmaskedCNPJAlphaNum = "12ABC34501DE3"
        let expectedMaskedCNPJAlphaNum = "12.ABC.345/01DE-3"
        let result = String().applyMask(cnpjAlphaNum: unmaskedCNPJAlphaNum)
        XCTAssertEqual(result, expectedMaskedCNPJAlphaNum)
    }
    
    func testApplyCNPJAlphaNumMaskMoreThan14Digits() {
        let unmaskedCNPJAlphaNum = "12ABC34501DE350"
        let expectedMaskedCNPJAlphaNum = "12.ABC.345/01DE-35"
        let result = String().applyMask(cnpjAlphaNum: unmaskedCNPJAlphaNum)
        XCTAssertEqual(result, expectedMaskedCNPJAlphaNum)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}

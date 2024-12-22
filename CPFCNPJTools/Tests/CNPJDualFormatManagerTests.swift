import XCTest
import CPFCNPJTools

class CNPJDualFormatManagerTests: XCTestCase {
    let sut = CNPJDualFormatManager()
    
    override class func setUp() {
        super.setUp()
    }
    
    func testValidateWhenTheCNPJAlphaNumIsNilOrEmpty() {
        let cnpjAlphaNum = ""
        let result = sut.validate(cnpjDualFormat: cnpjAlphaNum)
        XCTAssertEqual(result, .cnpjNull)
    }
    
    func testValidateWhenTheCNPJAlphaNumIsInvalidFormatWithLessThan14Characters() {
        let invalidCNPJAlphaNum = "12ABC34501DE3"
        let result = sut.validate(cnpjDualFormat: invalidCNPJAlphaNum)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJAlphaNumIsInvalidFormatWithMoreThan14Characters() {
        let invalidCNPJAlphaNum = "12ABC34501DE350"
        let result = sut.validate(cnpjDualFormat: invalidCNPJAlphaNum)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJAlphaNumIsEqualDigitsWith14Characters() {
        let invalidCNPJAlphaNum = "XXXXXXXXXXXXXX"
        let result = sut.validate(cnpjDualFormat: invalidCNPJAlphaNum)
        XCTAssertEqual(result, .equalDigits)
    }
    
    func testWhenTheCNPJAlphaNumIsValid() {
        let validCNPJAlphaNum = "12ABC34501DE35"
        let result = sut.validate(cnpjDualFormat: validCNPJAlphaNum)
        XCTAssertEqual(result, .valid)
    }
    
    func testWhenTheCNPJAlphaNumIsInvalidWith14Characters() {
        let invalidCNPJAlphaNum = "12ABC34501DE30"
        let result = sut.validate(cnpjDualFormat: invalidCNPJAlphaNum)
        XCTAssertEqual(result, .invalid)
    }
    
    func testValidateWhenTheCNPJAlphaNumHasNonAlphaNumericCharacters() {
        let cnpjAlphaNumWithSpecialChars = "12.BC.3#$/01DE-35"
        let result = sut.validate(cnpjDualFormat: cnpjAlphaNumWithSpecialChars)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJAlphaNumHasSpaces() {
        let cnpjAlphaNumWithSpaces = "  12 ABC 345 / 01DE - 35 "
        let result = sut.validate(cnpjDualFormat: cnpjAlphaNumWithSpaces)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidatesWhenCNPJAlphaNumIsValidAndHasOnlyNumbers() {
        let cnpjAlphaNumWithOnlyNumbers = "11444777000161"
        let result = sut.validate(cnpjDualFormat: cnpjAlphaNumWithOnlyNumbers)
        XCTAssertEqual(result, .valid)
    }
    
    func testGeneratedFakeCNPJAlphaNumMasked() {
        let fakeCNPJAlphaNumMasked = sut.generate()
        let result = sut.validate(cnpjDualFormat: fakeCNPJAlphaNumMasked)
        XCTAssertNotNil(result)
        
        let cnpjAlphaNumClean = fakeCNPJAlphaNumMasked.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        let fakeCNPJMasked = sut.mask(cnpjDualFormat: cnpjAlphaNumClean)
        XCTAssertEqual(fakeCNPJAlphaNumMasked, fakeCNPJMasked)
    }
        
    func testGeneratedFakeCNPJAlphaNum() {
        let fakeCNPJAlphaNum = sut.generate()
        let result = sut.validate(cnpjDualFormat: fakeCNPJAlphaNum)
        let fakeCNPJAlphaNumClean = fakeCNPJAlphaNum.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
        XCTAssertEqual(result, .valid)
        XCTAssertTrue(fakeCNPJAlphaNumClean.count == 14)
    }
    
    func testApplyCNPJAlphaNumMask() {
        let unmaskedCNPJAlphaNum = "12ABC34501DE35"
        let expectedMaskedCNPJAlphaNum = "12.ABC.345/01DE-35"
        let result = sut.mask(cnpjDualFormat: unmaskedCNPJAlphaNum)
        XCTAssertEqual(result, expectedMaskedCNPJAlphaNum)
    }
    
    func testApplyCNPJAlphaNumMaskLessThan14Digits() {
        let unmaskedCNPJAlphaNum = "12ABC34501DE3"
        let expectedMaskedCNPJAlphaNum = "12.ABC.345/01DE-3"
        let result = sut.mask(cnpjDualFormat: unmaskedCNPJAlphaNum)
        XCTAssertEqual(result, expectedMaskedCNPJAlphaNum)
    }
    
    func testApplyCNPJAlphaNumMaskMoreThan14Digits() {
        let unmaskedCNPJAlphaNum = "12ABC34501DE350"
        let expectedMaskedCNPJAlphaNum = "12.ABC.345/01DE-35"
        let result = sut.mask(cnpjDualFormat: unmaskedCNPJAlphaNum)
        XCTAssertEqual(result, expectedMaskedCNPJAlphaNum)
    }
    
    func testValidateWhenTheCNPJIsInvalidFormatWithLessThan14Characters() {
        let invalidCNPJ = "1144477700016"
        let result = sut.validate(cnpjDualFormat: invalidCNPJ)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJIsInvalidFormatWithMoreThan14Characters() {
        let invalidCNPJ = "114447770001610"
        let result = sut.validate(cnpjDualFormat: invalidCNPJ)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJIsEqualDigitsWith14Characters() {
        let invalidCNPJ = "11111111111111"
        let result = sut.validate(cnpjDualFormat: invalidCNPJ)
        XCTAssertEqual(result, .equalDigits)
    }
    
    func testValidateWhenTheCNPJIsValid() {
        let validCNPJ = "11444777000161"
        let result = sut.validate(cnpjDualFormat: validCNPJ)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenTheCNPJIsInvalidWith14Characters() {
        let invalidCNPJ = "11444777000160"
        let result = sut.validate(cnpjDualFormat: invalidCNPJ)
        XCTAssertEqual(result, .invalid)
    }
    
    func testApplyCNPJMask() {
        let unmaskedCNPJ = "11444777000161"
        let expectedMaskedCNPJ = "11.444.777/0001-61"
        let result = sut.mask(cnpjDualFormat: unmaskedCNPJ)
        XCTAssertEqual(result, expectedMaskedCNPJ)
    }
    
    func testApplyCNPJMaskMoreThan14Digits() {
        let unmaskedCNPJ = "114447770001610"
        let expectedMaskedCNPJ = "11.444.777/0001-61"
        let result = sut.mask(cnpjDualFormat: unmaskedCNPJ)
        XCTAssertEqual(result, expectedMaskedCNPJ)
    }
    
    func testValidateWhenTheCNPJHasSpaces() {
        let cnpjWithSpaces = "  11 444 777 / 0001 - 61 "
        let result = sut.validate(cnpjDualFormat: cnpjWithSpaces)
        XCTAssertEqual(result, .valid)
    }
    
    func testCNPJWithAlphaNumCharacters() {
        let cnpjWithAlphaNumCharacters = "12ABC34501DE35"
        let result = sut.isCNPJAlphanumeric(cnpjWithAlphaNumCharacters)
        XCTAssertTrue(result)
    }
    
    func testCNPJWithOnlyNumber() {
        let cnpjWithOnlyNumber = "11444777000161"
        let result = sut.isCNPJAlphanumeric(cnpjWithOnlyNumber)
        XCTAssertFalse(result)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}

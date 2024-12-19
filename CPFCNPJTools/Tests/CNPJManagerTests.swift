import XCTest
import CPFCNPJTools

class CNPJManagerTests: XCTestCase {
    
    override class func setUp() {
        super .setUp()
    }
    
    func testValidateWhenTheCNPJIsNilOrEmpty() {
        let sut = CNPJManager()
        let validCNPJ = ""
        let result = sut.validate(cnpj: validCNPJ)
        XCTAssertEqual(result, .cnpjNull)
    }
    
    func testValidateWhenTheCNPJIsInvalidFormatWithLessThan14Characters() {
        let sut = CNPJManager()
        let invalidCNPJ = "1234567800010"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJIsInvalidFormatWithMoreThan14Characters() {
        let sut = CNPJManager()
        let invalidCNPJ = "123456780001012"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJIsEqualDigitsWith14Characters() {
        let sut = CNPJManager()
        let invalidCNPJ = "11111111111111"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .equalDigits)
    }
    
    func testValidateWhenTheCNPJIsValid() {
        let sut = CNPJManager()
        let validCNPJ = "44024904000122"
        let result = sut.validate(cnpj: validCNPJ)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenTheCNPJIsInvalidWith14Characters() {
        let sut = CNPJManager()
        let invalidCNPJ = "12345678000190"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .invalid)
    }
    
    func testGeneratedFakeCNPJMasked() {
        let sut = CNPJManager()
        let result = sut.generateMasked()
        XCTAssertNotNil(result)
        
        let regex = try! NSRegularExpression(pattern: "^\\d{2}\\.\\d{3}\\.\\d{3}\\/\\d{4}\\-\\d{2}$")
        let range = NSRange(location: 0, length: result!.utf16.count)
        let match = regex.firstMatch(in: result!, options: [], range: range)
        XCTAssertNotNil(match, "O CNPJ gerado não tem o formato correto")
    }
    
    func testGeneratedFakeCNPJ() {
        let sut = CNPJManager()
        let result = sut.generate()
        XCTAssertTrue(result.count == 14)
    }
    
    func testApplyCNPJMask() {
        let sut = CNPJManager()
        let unmaskedCNPJ = "12345678000190"
        let expectedMaskedCNPJ = "12.345.678/0001-90"
        let result = sut.mask(cnpj: unmaskedCNPJ)
        XCTAssertEqual(result, expectedMaskedCNPJ)
    }
    
    func testApplyCNPJMaskMoreThan14Digits() {
        let sut = CNPJManager()
        let unmaskedCNPJ = "123456780001001"
        let expectedMaskedCNPJ = "12.345.678/0001-00"
        let result = sut.mask(cnpj: unmaskedCNPJ)
        XCTAssertEqual(result, expectedMaskedCNPJ)
    }
    
    override class func tearDown() {
        super .tearDown()
    }
}

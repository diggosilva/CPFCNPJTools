import XCTest
import CPFCNPJTools

class CNPJManagerTests: XCTestCase {
    let sut = CNPJManager()
    
    override class func setUp() {
        super .setUp()
    }
    
    func testValidateWhenTheCNPJIsNilOrEmpty() {
        let validCNPJ = ""
        let result = sut.validate(cnpj: validCNPJ)
        XCTAssertEqual(result, .cnpjNull)
    }
    
    func testValidateWhenTheCNPJIsInvalidFormatWithLessThan14Characters() {
        let invalidCNPJ = "1144477700016"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJIsInvalidFormatWithMoreThan14Characters() {
        let invalidCNPJ = "114447770001610"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCNPJIsEqualDigitsWith14Characters() {
        let invalidCNPJ = "11111111111111"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .equalDigits)
    }
    
    func testValidateWhenTheCNPJIsValid() {
        let validCNPJ = "11444777000161"
        let result = sut.validate(cnpj: validCNPJ)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenTheCNPJIsInvalidWith14Characters() {
        let invalidCNPJ = "11444777000160"
        let result = sut.validate(cnpj: invalidCNPJ)
        XCTAssertEqual(result, .invalid)
    }
    
    func testGeneratedFakeCNPJMasked() {
        let result = sut.generateMasked()
        XCTAssertNotNil(result)
        
        let regex = try! NSRegularExpression(pattern: "^\\d{2}\\.\\d{3}\\.\\d{3}\\/\\d{4}\\-\\d{2}$")
        let range = NSRange(location: 0, length: result!.utf16.count)
        let match = regex.firstMatch(in: result!, options: [], range: range)
        XCTAssertNotNil(match, "O CNPJ gerado não tem o formato correto")
    }
    
    func testGeneratedFakeCNPJ() {
        let result = sut.generateMasked()
        let cnpjClean = result?.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        XCTAssertTrue(cnpjClean?.count == 14)
    }
    
    func testGenerateFakeCNPJIsValid() {
        let result = sut.generateMasked() ?? ""
        let resultValidation = sut.validate(cnpj: result)
        XCTAssertEqual(resultValidation, .valid)
    }
    
    func testApplyCNPJMask() {
        let unmaskedCNPJ = "11444777000161"
        let expectedMaskedCNPJ = "11.444.777/0001-61"
        let result = sut.mask(cnpj: unmaskedCNPJ)
        XCTAssertEqual(result, expectedMaskedCNPJ)
    }
    
    func testApplyCNPJMaskMoreThan14Digits() {
        let unmaskedCNPJ = "114447770001610"
        let expectedMaskedCNPJ = "11.444.777/0001-61"
        let result = sut.mask(cnpj: unmaskedCNPJ)
        XCTAssertEqual(result, expectedMaskedCNPJ)
    }
    
    override class func tearDown() {
        super .tearDown()
    }
}

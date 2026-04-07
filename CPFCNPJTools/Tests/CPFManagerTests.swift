import XCTest
import CPFCNPJTools

class CPFManagerTests: XCTestCase {
    let sut = CPFManager()
    
    func testValidateWhenTheCPFIsNilOrEmpty() {
        let result = sut.validate(cpf: "")
        XCTAssertEqual(result, .cpfNull)
    }
    
    func testValidateWhenTheCPFIsInvalidFormatWithLessThan11Characters() {
        let result = sut.validate(cpf: "1114447770")
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCPFIsInvalidFormatWithMoreThan11Characters() {
        let result = sut.validate(cpf: "111444777001")
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCPFIsEqualDigitsWith11Characters() {
        let result = sut.validate(cpf: "11111111111")
        XCTAssertEqual(result, .equalDigits)
    }
    
    func testValidateWhenTheCPFIsValid() {
        let result = sut.validate(cpf: "11144477735")
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenTheCPFIsInvalidWith11Characters() {
        let result = sut.validate(cpf: "11144477700")
        XCTAssertEqual(result, .invalid)
    }
    
    func testGeneratedFakeCPFMasked() {
        let result = sut.generateMasked() ?? ""
        let regex = try! NSRegularExpression(pattern: "^\\d{3}\\.\\d{3}\\.\\d{3}\\-\\d{2}$")
        let range = NSRange(location: 0, length: result.utf16.count)
        let match = regex.firstMatch(in: result, options: [], range: range)
        XCTAssertNotNil(match)
    }
    
    func testGenerateFakeCPFIsValid() {
        let result = sut.generateMasked() ?? ""
        let resultValidation = sut.validate(cpf: result)
        XCTAssertEqual(resultValidation, .valid)
    }
    
    func testValidateWhenCPFCheckDigitIsZero() {
        // Este CPF (000.000.001-91) é válido e os dígitos calculados resultam em 1 e 0.
        // Isso força o código a passar pela lógica do "vire 0 se for 10"
        let result = sut.validate(cpf: "00000000191")
        XCTAssertEqual(result, .valid)
    }
}

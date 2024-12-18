import XCTest
import CPFCNPJTools

class CPFValidatorTests: XCTestCase {
    let sut = CPFManager()
    
    override class func setUp() {
        super.setUp()
    }
    
    func testValidateWhenTheCPFIsNilOrEmpty() {
        let invalidCPF = ""
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .cpfNull)
    }
    
    func testValidateWhenTheCPFsInvalidFormatWithLessThan11Characters() {
        let invalidCPF = "1114447773"
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCPFsInvalidFormatWithMoreThan11Characters() {
        let invalidCPF = "111444777350"
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenFirstDigitIsZero() {
        let validCPF = "12345678909"
        let result = sut.validate(cpf: validCPF)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenSecondDigitIsZero() {
        let validCPF = "46761018480"
        let result = sut.validate(cpf: validCPF)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenTheCPFHasNonNumericCharacters() {
        let invalidCPF = "111.444.77A-35"
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCPFIsEqualDigitsWith11Characters() {
        let invalidCPF = "11111111111"
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .equalDigits)
    }
    
    func testValidateWhenTheCPFIsValid() {
        let validCPF = "11144477735"
        let result = sut.validate(cpf: validCPF)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenTheCPFIsInvalidWith11Characters() {
        let invalidCPF = "11144477733"
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .invalid)
    }
    
    func testGenerateFakeCPFMasked() {
        let result = sut.generateMasked()
        XCTAssertNotNil(result)
       
        // Expressão regular para verificar o formato do CPF
        let regex = try! NSRegularExpression(pattern: "^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$")
        let range = NSRange(location: 0, length: result!.utf16.count)
        let match = regex.firstMatch(in: result!, options: [], range: range)

//        // Verifique se há uma correspondência
        XCTAssertNotNil(match, "O CPF gerado não tem o formato esperado")
    }
    
    func testGenerateFakeCPF() {
        let result = sut.generateMasked()
        let cpfClean = result?.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        XCTAssertTrue(cpfClean?.count == 11)
    }
    
    func testGenerateFakeCPFIsValid() {
        let result = sut.generateMasked() ?? ""
        let resultValidation = sut.validate(cpf: result)
        XCTAssertEqual(resultValidation, .valid)
    }
    
    func testApplyCPFMask() {
        let unmaskedCPF = "11144477735"
        let expectedMaskedCPF = "111.444.777-35"
        let result = sut.mask(cpf: unmaskedCPF)
        XCTAssertEqual(result, expectedMaskedCPF)
    }
    
    func testApplyCPFMaskMoreThan11Digits() {
        let unmaskedCPF = "111444777350"
        let expectedMaskedCPF = "111.444.777-35"
        let result = sut.mask(cpf: unmaskedCPF)
        XCTAssertEqual(result, expectedMaskedCPF)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}

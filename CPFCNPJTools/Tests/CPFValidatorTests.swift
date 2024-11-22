import XCTest
import CPFCNPJTools

class CPFValidatorTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
    }
    
    func testValidateWhenTheCPFIsNilOrEmpty() {
        let sut = CPFValidator()
        let invalidCPF = ""
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .cpfNull)
    }
    
    func testValidateWhenCPFHasLessThan11Characters() {
        let sut = CPFValidator()
        let invalidCPF = "123456789"
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCPFIsGreaterThan11Characters() {
        let sut = CPFValidator()
        let invalidCPF = "123456789101"
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenFirstDigitIsZero() {
        let sut = CPFValidator()
        let validCPF = "12345678909"
        let result = sut.validate(cpf: validCPF)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenSecondDigitIsZero() {
        let sut = CPFValidator()
        let validCPF = "46761018480"
        let result = sut.validate(cpf: validCPF)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenTheCPFHasNonNumericCharacters() {
        let sut = CPFValidator()
        let invalidCPF = "123.456.78a-90"
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testValidateWhenTheCPFIsEqualDigitsWith11Characters() {
        let sut = CPFValidator()
        let invalidCPF = "11111111111"
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .equalDigits)
    }
    
    func testValidateWhenTheCPFIsValid() {
        let sut = CPFValidator()
        let validCPF = "12345678909"
        let result = sut.validate(cpf: validCPF)
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenTheCPFIsInvalidWith11Characters() {
        let sut = CPFValidator()
        let invalidCPF = "12345678901"
        let result = sut.validate(cpf: invalidCPF)
        XCTAssertEqual(result, .invalid)
    }
    
    func testGenerateFakeCPFMasked() {
        let sut = CPFValidator()
        let result = sut.generateFakeCPFMasked()
        XCTAssertNotNil(result)
       
        // Expressão regular para verificar o formato do CPF
        let regex = try! NSRegularExpression(pattern: "^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$")
        let range = NSRange(location: 0, length: result!.utf16.count)
        let match = regex.firstMatch(in: result!, options: [], range: range)

//        // Verifique se há uma correspondência
        XCTAssertNotNil(match, "O CPF gerado não tem o formato esperado")
    }
    
    func testGenerateFakeCPF() {
        let sut = CPFValidator()
        let result = sut.generateFakeCPF()
        XCTAssertTrue(result.count == 11)
    }
    
    func testGenerateFakeCPFIsValid() {
        let sut = CPFValidator()
        let result = sut.generateFakeCPF()
        let resultValidation = sut.validate(cpf: result)
        XCTAssertEqual(resultValidation, .valid)
    }
    
    func testFormatCPFWhenContains11Digits() {
        let sut = CPFValidator()
        let unformattedCPF = "12345678910"
        let expectedFormattedCPF = "123.456.789-10"
        let result = sut.formattedCPF(unformattedCPF)
        XCTAssertEqual(result, expectedFormattedCPF)
    }
    
    func testFormatCPFContainsLessThan11Digits() {
        let sut = CPFValidator()
        let lessThan11DigitsCPF = "123456789"
        let result = sut.formattedCPF(lessThan11DigitsCPF)
        XCTAssertNil(result)
    }
    
    func testFormatCPFContainsMoreThan11Digits() {
        let sut = CPFValidator()
        let lessThan11DigitsCPF = "123456789101"
        let result = sut.formattedCPF(lessThan11DigitsCPF)
        XCTAssertNil(result)
    }
    
    func testApplyCPFMask() {
        let sut = CPFValidator()
        let unmaskedCPF = "12345678910"
        let expectedMaskedCPF = "123.456.789-10"
        let result = sut.applyCPFMask(cpf: unmaskedCPF)
        XCTAssertEqual(result, expectedMaskedCPF)
    }
    
    func testApplyCPFMaskMoreThan11Digits() {
        let sut = CPFValidator()
        let unmaskedCPF = "123456789101"
        let expectedMaskedCPF = "123.456.789-10"
        let result = sut.applyCPFMask(cpf: unmaskedCPF)
        XCTAssertEqual(result, expectedMaskedCPF)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}

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
    
    func testValidateWhenTheCPFIsInvalidFormatWith10Characters() {
        let sut = CPFValidator()
        let invalidCPF = "123456890"
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
    
    func testGeneratedFakeCPF() {
        let sut = CPFValidator()
        let result = sut.generateFakeCPF()
        XCTAssertFalse(result.isEmpty, "O CPF gerado não deve ser vazio")
        
        // Expressão regular para verificar o formato do CPF
        let regex = try! NSRegularExpression(pattern: "^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$")
        let range = NSRange(location: 0, length: result.utf16.count)
        let match = regex.firstMatch(in: result, options: [], range: range)
        
        // Verifique se há uma correspondência
        XCTAssertNotNil(match, "O CPF gerado não tem o formato esperado")
    }
    
    func testApplyCPFMask() {
        let sut = CPFValidator()
        let unmaskedCPF = "12345678910"
        let expectedMaskedCPF = "123.456.789-10"
        let result = sut.applyCPFMask(cpf: unmaskedCPF)
        XCTAssertEqual(result, expectedMaskedCPF)
        
        XCTAssertGreaterThanOrEqual(unmaskedCPF.count, 11)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}

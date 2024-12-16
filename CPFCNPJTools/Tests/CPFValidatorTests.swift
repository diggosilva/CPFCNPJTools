import XCTest
import CPFCNPJTools

class CPFValidatorTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
    }
    
    func testValidateWhenTheCPFIsNilOrEmpty() {
        let invalidCPF = ""
        let result = invalidCPF.isValidCPF()
        XCTAssertFalse(result, "O CPF vazio deveria retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCPFsInvalidFormatWithLessThan11Characters() {
        let invalidCPF = "1114447773"
        let result = invalidCPF.isValidCPF()
        XCTAssertFalse(result, "O CPF com menos de 11 caracteres deveria retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCPFsInvalidFormatWithMoreThan11Characters() {
        let invalidCPF = "111444777350"
        let result = invalidCPF.isValidCPF()
        XCTAssertFalse(result, "O CPF com mais de 11 caracteres deveria retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCPFsValidWithFirstDigitIsZero() {
        let validCPF = "12345678909"
        let result = validCPF.isValidCPF()
        XCTAssertTrue(result, "O CPF válido com o primeiro dígito 0 deveria retornar true, mas retornou \(result)")
    }
    
    func testValidateWhenTheCPFsValidWithSecondDigitIsZero() {
        let validCPF = "46761018480"
        let result = validCPF.isValidCPF()
        XCTAssertTrue(result, "O CPF válido com o segundo dígito 0 deveria retornar true, mas retornou \(result)")
    }
    
    func testValidateWhenTheCPFHasNonNumericCharacters() {
        let invalidCPF = "123.456.78A-09"
        let result = invalidCPF.isValidCPF()
        XCTAssertFalse(result, "O CPF com caracteres não numéricos deveria retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCPFIsEqualDigitsWith11Characters() {
        let invalidCPF = "11111111111"
        let result = invalidCPF.isValidCPF()
        XCTAssertFalse(result, "O CPF com 11 digitos iguais deveria retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCPFIsValid() {
        let validCPF = "11144477735"
        let result = validCPF.isValidCPF()
        XCTAssertTrue(result, "O CPF válido deveria retornar true, mas retornou \(result)")
    }
    
    func testValidateWhenTheCPFIsInvalidWith11Characters() {
        let invalidCPF = "11144477730"
        let result = invalidCPF.isValidCPF()
        XCTAssertFalse(result, "O CPF com 11 digitos inválidos deveria retornar false, mas retornou \(result)")
    }
    
    func testGenerateFakeCPFMasked() {
        let fakeCPF = String().generateFakeCPF()
        let result = fakeCPF.isValidCPF()
        XCTAssertTrue(result, "O CPF gerado aleatoriamente deveria ser válido, mas retornou \(result)")
        
        let fakeCPFMasked = fakeCPF.applyMask(cpf: fakeCPF)
        XCTAssertNotNil(fakeCPFMasked, "O CPF gerado não tem o formato correto")
    }
    
    func testGenerateFakeCPF() {
        let fakeCPF = String().generateFakeCPF()
        let result = fakeCPF.isValidCPF()
        let fakeCPFClean = fakeCPF.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        XCTAssertTrue(result, "O CPF gerado aleatoriamente deveria ser válido, mas retornou \(result)")
        XCTAssertTrue(fakeCPFClean.count == 11)
    }
    
    func testApplyCPFMask() {
        let unmaskedCPF = "11144477735"
        let expectedMaskedCPF = "111.444.777-35"
        let result = String().applyMask(cpf: unmaskedCPF)
        XCTAssertEqual(result, expectedMaskedCPF)
    }
    
    func testApplyCPFMaskLessThan11Digits() {
        let unformattedCPF = "1114447773"
        let expectedFormattedCPF = "111.444.777-3"
        let result = String().applyMask(cpf: unformattedCPF)
        XCTAssertEqual(result, expectedFormattedCPF)
    }
    
    func testApplyCPFMaskMoreThan11Digits() {
        let unformattedCPF = "111444777350"
        let expectedFormattedCPF = "111.444.777-35"
        let result = String().applyMask(cpf: unformattedCPF)
        XCTAssertEqual(result, expectedFormattedCPF)
    }
    
    override class func tearDown() {
        super.tearDown()
    }
}

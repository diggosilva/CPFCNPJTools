import XCTest
import CPFCNPJTools

class CNPJValidatorTests: XCTestCase {
    
    override class func setUp() {
        super .setUp()
    }
    
    func testValidateWhenTheCNPJIsNilOrEmpty() {
        let validCNPJ = ""
        let result = validCNPJ.isValidCNPJ()
        XCTAssertFalse(result, "O CNPJ vazio deveria retornar false, mas retornou \(result)")
    }

    func testValidateWhenTheCNPJIsInvalidFormatWithLessThan14Characters() {
        let invalidCNPJ = "1144477700016"
        let result = invalidCNPJ.isValidCNPJ()
        XCTAssertFalse(result, "O CNPJ com menos de 14 caracteres deve retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJIsInvalidFormatWithMoreThan14Characters() {
        let invalidCNPJ = "114447770001610"
        let result = invalidCNPJ.isValidCNPJ()
        XCTAssertFalse(result, "O CNPJ com mais de 14 caracteres deve retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJIsEqualDigitsWith14Characters() {
        let invalidCNPJ = "11111111111111"
        let result = invalidCNPJ.isValidCNPJ()
        XCTAssertFalse(result, "O CNPJ com todos os dígitos iguais deveria retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJIsValid() {
        let invalidCNPJ = "11444777000161"
        let result = invalidCNPJ.isValidCNPJ()
        XCTAssertTrue(result, "O CNPJ válido deveria retornar true, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJIsInvalidWith14Characters() {
        let invalidCNPJ = "11444777000160"
        let result = invalidCNPJ.isValidCNPJ()
        XCTAssertFalse(result, "O CNPJ inválido com 14 caracteres deveria retornar false, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJHasNonNumericCharacters() {
        let cnpjWithSpecialChars = "11.444.777/0001-61" // CNPJ com pontuação
        let result = cnpjWithSpecialChars.isValidCNPJ()
        XCTAssertTrue(result, "O CNPJ com caracteres especiais (pontuação) deveria ser válido, mas retornou \(result)")
    }
    
    func testValidateWhenTheCNPJHasSpacesOrSpecialChars() {
        let cnpjWithSpaces = "  11 444 777 / 0001 - 61 " // CNPJ com espaços extras
        let result = cnpjWithSpaces.isValidCNPJ()
        XCTAssertTrue(result, "O CNPJ com espaços extras ou caracteres especiais deveria ser válido, mas retornou \(result)")
    }
    
    func testGeneratedFakeCNPJMasked() {
        let fakeCNPJ = String().generateFakeCNPJ()
        let result = fakeCNPJ.isValidCNPJ()
        XCTAssertTrue(result, "O CNPJ gerado aleatoriamente deveria ser válido, mas retornou \(result)")
        
        let fakeCNPJMasked = String().applyMask(cnpj: fakeCNPJ)
        XCTAssertNotNil(fakeCNPJMasked, "O CNPJ gerado não tem o formato correto")
    }
    
    func testGeneratedFakeCNPJ() {
        let fakeCNPJ = String().generateFakeCNPJ()
        let result = fakeCNPJ.isValidCNPJ()
        let fakeCNPJClean = fakeCNPJ.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        
        XCTAssertTrue(result, "O CNPJ gerado aleatoriamente deveria ser válido, mas retornou \(result)")
        XCTAssertTrue(fakeCNPJClean.count == 14)
    }
    
    func testApplyCNPJMask() {
        let unmaskedCNPJ = "11444777000161"
        let expectedMaskedCNPJ = "11.444.777/0001-61"
        let result = String().applyMask(cnpj: unmaskedCNPJ)
        XCTAssertEqual(result, expectedMaskedCNPJ)
    }
    
    func testApplyCNPJMaskLessThan14Digits() {
        let unmaskedCNPJ = "1144477700016"
        let expectedMaskedCNPJ = "11.444.777/0001-6"
        let result = String().applyMask(cnpj: unmaskedCNPJ)
        XCTAssertEqual(result, expectedMaskedCNPJ)
    }
    
    func testApplyCNPJMaskMoreThan14Digits() {
        let unmaskedCNPJ = "114447770001610"
        let expectedMaskedCNPJ = "11.444.777/0001-61"
        let result = String().applyMask(cnpj: unmaskedCNPJ)
        XCTAssertEqual(result, expectedMaskedCNPJ)
    }
    
    override class func tearDown() {
        super .tearDown()
    }
}

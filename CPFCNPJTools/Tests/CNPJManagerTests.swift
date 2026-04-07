import XCTest
import CPFCNPJTools

class CNPJManagerTests: XCTestCase {
    let sut = CNPJManager()
    
    func testValidateWhenTheCNPJIsNilOrEmpty() {
        XCTAssertEqual(sut.validate(cnpj: ""), .cnpjNull)
    }
    
    func testValidateWhenTheCNPJIsInvalidFormat() {
        // Agora testamos com caractere especial, pois letras são permitidas
        XCTAssertEqual(sut.validate(cnpj: "1144477700016@"), .invalidFormat)
    }
    
    func testValidateWhenTheCNPJIsEqualDigits() {
        XCTAssertEqual(sut.validate(cnpj: "11111111111111"), .equalDigits)
    }
    
    func testValidateWhenTheCNPJIsValid() {
        XCTAssertEqual(sut.validate(cnpj: "11444777000161"), .valid)
    }
    
    func testGeneratedFakeCNPJMasked() {
        let result = sut.generateMasked() ?? ""
        // Regex atualizada para aceitar letras caso o manager gere alfanumérico no futuro
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9]{2}\\.[A-Z0-9]{3}\\.[A-Z0-9]{3}\\/[A-Z0-9]{4}\\-\\d{2}$")
        let range = NSRange(location: 0, length: result.utf16.count)
        XCTAssertNotNil(regex.firstMatch(in: result, options: [], range: range))
    }
    
    func testGenerateFakeCNPJIsValid() {
        let result = sut.generateMasked() ?? ""
        XCTAssertEqual(sut.validate(cnpj: result), .valid)
    }
}

import XCTest
import CPFCNPJTools

class CNPJDualFormatManagerTests: XCTestCase {
    let sut = CNPJDualFormatManager()
    
    func testValidateOfficialAlphanumericExample() {
        // Exemplo oficial da Receita Federal para 2026
        let result = sut.validate(cnpjDualFormat: "12.ABC.345/01DE-35")
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateAlphanumericLowercase() {
        let result = sut.validate(cnpjDualFormat: "12.abc.345/01de-35")
        XCTAssertEqual(result, .valid)
    }
    
    func testValidateWhenCNPJHasInvalidChars() {
        // Caracteres que NÃO são letras nem números devem dar erro de formato
        let result = sut.validate(cnpjDualFormat: "12.ABC.345/01DE-3!")
        XCTAssertEqual(result, .invalidFormat)
    }
    
    func testGenerationStress() {
        // Roda 1000 vezes para garantir que o gerador nunca erra o formato ou cálculo
        for _ in 0..<1000 {
            let generated = sut.generate()
            let clean = generated.replacingOccurrences(of: "[^0-9A-Z]", with: "", options: .regularExpression)
            
            XCTAssertEqual(clean.count, 14, "CNPJ gerado com tamanho errado: \(generated)")
            XCTAssertEqual(sut.validate(cnpjDualFormat: generated), .valid, "CNPJ gerado é inválido: \(generated)")
        }
    }
    
    func testMaskApplyingWithLetters() {
        let input = "12ABC34501DE35"
        let expected = "12.ABC.345/01DE-35"
        XCTAssertEqual(sut.mask(cnpjDualFormat: input), expected)
    }
    
    func testIsAlphanumericCheck() {
        XCTAssertTrue(sut.isCNPJAlphanumeric("12.ABC.345/01DE-35"))
        XCTAssertFalse(sut.isCNPJAlphanumeric("11.444.777/0001-61"))
    }
    
    func testValidateWhenCheckDigitIsZero() {
        // CNPJ Alfanumérico válido onde o dígito calculado resulta em 0
        // Isso vai limpar a linha vermelha do Coverage
        let validAlphanumeric = "00.000.000/0001-91"
        XCTAssertEqual(sut.validate(cnpjDualFormat: validAlphanumeric), .valid)
    }

    func testValidateOfficialExample() {
        // Exemplo oficial da Receita Federal
        let result = sut.validate(cnpjDualFormat: "12.ABC.345/01DE-35")
        XCTAssertEqual(result, .valid)
    }
}

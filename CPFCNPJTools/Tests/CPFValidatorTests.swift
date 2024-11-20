import XCTest
import CPFCNPJTools

class CPFValidatorTests: XCTestCase {
  
  override class func setUp() {
    super.setUp()
  }
  
  func testValidateWhenTheCPFIsInvalid() {
    let sut = CPFValidator()
    let invalidCPF = "12345678901"
    let result = sut.validate(cpf: invalidCPF)
    XCTAssertEqual(result, .invalid)
  }
  
  func testValidateWhenTheCPFIsInvalidFormatWith10Characters() {
    let sut = CPFValidator()
    let invalidCPF = "123456890"
    let result = sut.validate(cpf: invalidCPF)
    XCTAssertEqual(result, .invalidFormat)
  }
  
  override class func tearDown() {
    super.tearDown()
  }
  
}

//
//  CPFUtils.swift
//  CPF-CNPJ-TOOLS
//
//  Created by Diggo Silva on 16/11/24.
//

import Foundation

func formattedCPF(_ cpf: String) -> String {
    guard cpf.count == 11 else { return cpf }
    let formattedCPF = "\(cpf.prefix(3)).\(cpf.dropFirst(3).prefix(3)).\(cpf.dropFirst(6).prefix(3))-\(cpf.suffix(2))"
    return formattedCPF
}

func calculateCPFCheckSum(cpfBaseDigits: [Int], multiplyBy: Int) -> Int {
    var multiplyBy = multiplyBy
    var checkSum = 0
    
    for digit in cpfBaseDigits {
        checkSum += digit * multiplyBy
        multiplyBy -= 1
    }
    return checkSum
}

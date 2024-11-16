//
//  ViewController.swift
//  CPF-CNPJ-TOOLS
//
//  Created by Diggo Silva on 16/11/24.
//

import UIKit

class CPFViewController: UIViewController {
    
    let cpfView = CPFView()
    
    override func loadView() {
        super.loadView()
        view = cpfView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        setDelegatesAndDataSources()
    }
    
    private func setNavBar() {
        title = "Validador CPF"
    }
    
    private func setDelegatesAndDataSources() {
        cpfView.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

extension CPFViewController: CPFViewDelegate {
    func validateCPF() {
        var cpf = cpfView.cpfResult.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        print("Tá Tentando Validar: \(cpf)")
    }
    
    func generateCPF() {
        
    }
}

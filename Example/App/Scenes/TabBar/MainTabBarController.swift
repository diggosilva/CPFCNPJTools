//
//  MainTabBarController.swift
//  Example
//
//  Created by Diggo Silva on 07/04/26.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    private let vc1 = UINavigationController(rootViewController: CNPJDualFormatViewController())
    private let vc2 = UINavigationController(rootViewController: CNPJViewController())
    private let vc3 = UINavigationController(rootViewController: CPFViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    func setupViewControllers() {
        vc1.tabBarItem.title = "CNPJ Dual"
        vc1.tabBarItem.image = UIImage(systemName: "document")
        vc1.tabBarItem.selectedImage = UIImage(systemName: "document.fill")
        
        vc2.tabBarItem.title = "CNPJ"
        vc2.tabBarItem.image = UIImage(systemName: "document")
        vc2.tabBarItem.selectedImage = UIImage(systemName: "document.fill")
        
        vc3.tabBarItem.title = "CPF"
        vc3.tabBarItem.image = UIImage(systemName: "document")
        vc3.tabBarItem.selectedImage = UIImage(systemName: "document.fill")
        
        viewControllers = [vc1, vc2, vc3]
    }
}

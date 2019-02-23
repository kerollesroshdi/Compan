//
//  CreateEmployeeController.swift
//  Compan
//
//  Created by Kerolles Roshdi on 2/23/19.
//  Copyright © 2019 Kerolles Roshdi. All rights reserved.
//

import UIKit

class CreateEmployeeController: UIViewController {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Name"
        return label
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Create Employee"
        setupCancelButtonInNavBar()
        setupDoneButtonInNavBar(selector: #selector(handelDone))
        
        view.backgroundColor = .darkBlue
        setupUI()
        
    }
    
    @objc private func handelDone() {
        guard let employeeName = nameTextField.text else { return }
        let error = CoreDataManager.shared.createEmployee(WithName: employeeName)
        if let error = error {
            print("Employee Creation Error:", error)
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
    private func setupUI() {
        let lightBlueBackgroundView = setupLightBlueBackgroundView(withHight: 200)
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: lightBlueBackgroundView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        nameTextField.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        
    }
    

}

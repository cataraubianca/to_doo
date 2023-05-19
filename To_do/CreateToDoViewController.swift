//
//  CreateToDo.swift
//  To_do
//
//  Created by Catarau, Bianca on 18.04.2023.
//

import UIKit

class CreateToDoViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel = CreateToDoViewModel()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.text = "Create a new to do item"
        return label
    }()
    
    private let itemTextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 24)
        tf.textColor = .black
        tf.backgroundColor = .white
        
        return tf
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create item", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(createItemPressed), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    func configureUI() {
        view.backgroundColor = .black
        
        //Title label
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft:16, paddingRight: 16)
        
        //Button
        view.addSubview(itemTextField)
        itemTextField.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 128, paddingLeft:16, paddingRight: 16, height: 40)
        
        
        //Cancel Button
        view.addSubview(cancelButton)
        cancelButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft:32, paddingBottom: 32, paddingRight: 32, height: 50)
        
        //Button
        view.addSubview(createButton)
        createButton.anchor(left: view.leftAnchor, bottom: cancelButton.topAnchor, right: view.rightAnchor, paddingLeft:32, paddingBottom: 32, paddingRight: 32, height: 50)
    }
    
    @objc func createItemPressed() {
        guard let text = itemTextField.text else {
            return
        }
        viewModel.createTask(text: text) { [weak self] isSuccesfull in
            guard let strongSelf = self else { return }
            if isSuccesfull {
                DispatchQueue.main.async {
                    strongSelf.dismissScreen()
                }
                
            } else {
                print("error")
            }
        }
    }
    
    @objc func dismissScreen() {
        dismiss(animated: true)
    }
    // MARK: - Helpers
    
}

extension CreateToDoViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

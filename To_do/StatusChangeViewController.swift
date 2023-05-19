//
//  FilterByViewController.swift
//  To_do
//
//  Created by Catarau, Bianca on 21.04.2023.
//

import UIKit

class StatusChangeViewController: UIViewController {
    
    // MARK: - Properties
    var viewModel: StatusChangeViewModel?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.text = "Set status"
        label.textAlignment = .center
        return label
    }()

    
    private lazy var statusToDo: UIButton = {
        let button = UIButton()
        button.setTitle("To do ", for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = 24
        button.backgroundColor = .systemTeal
//        button.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var statusInProgress: UIButton = {
        let button = UIButton()
        button.setTitle("In progress ", for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = 24
        button.backgroundColor = .systemTeal
//        button.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var statusDone: UIButton = {
        let button = UIButton()
        button.setTitle("Done ", for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = 24
        button.backgroundColor = .systemTeal
//        button.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.white, for: .normal)
//        button.titleLabel?.font = 24
        button.backgroundColor = .systemRed
//        button.addTarget(self, action: #selector(dismissScreen), for: .touchUpInside)
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
        
        //Cancel Button
        view.addSubview(cancelButton)
        cancelButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft:32, paddingBottom: 32, paddingRight: 32, height: 50)
        
        //Button
        view.addSubview(statusDone)
        statusDone.anchor(left: view.leftAnchor, bottom: cancelButton.topAnchor, right: view.rightAnchor, paddingLeft:32, paddingBottom: 32, paddingRight: 32, height: 50)
        statusDone.addTarget(self, action: #selector(updateTaskStatusDone), for: UIControl.Event.touchUpInside)
        
        view.addSubview(statusInProgress)
        statusInProgress.anchor(left: view.leftAnchor, bottom: statusDone.topAnchor, right: view.rightAnchor, paddingLeft:32, paddingBottom: 32, paddingRight: 32, height: 50)
        statusInProgress.addTarget(self, action: #selector(updateTaskStatusInProgress), for: UIControl.Event.touchUpInside)
        
        view.addSubview(statusToDo)
        statusToDo.anchor(left: view.leftAnchor, bottom: statusInProgress.topAnchor, right: view.rightAnchor, paddingLeft:32, paddingBottom: 32, paddingRight: 32, height: 50)
        statusToDo.addTarget(self, action: #selector(updateTaskStatusToDo), for: UIControl.Event.touchUpInside)

    }
    
    @objc func updateTaskStatusDone() {
        viewModel?.setStatus(status: TaskState.done)
    }
    
    @objc func updateTaskStatusInProgress() {
        viewModel?.setStatus(status: TaskState.inProgress)
    }
    
    @objc func updateTaskStatusToDo() {
        viewModel?.setStatus(status: TaskState.toDo)
    }
    
    // MARK: - Helpers
    
}

extension StatusChangeViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

extension StatusChangeViewController: StatusChangeViewModelDelegate {
    func didChangeStatus() {
        dismiss(animated: true)
    }
}

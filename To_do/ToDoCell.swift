//
//  ToDoCell.swift
//  To_do
//
//  Created by Catarau, Bianca on 18.04.2023.
//

import UIKit

protocol ToDoCellDelegate: AnyObject {
    func updateState(cell: ToDoCell) 
}

class ToDoCell: UITableViewCell {
    // MARK: - Properties
    weak var delegate: (any ToDoCellDelegate)?
    static let reuseId = String(describing: ToDoCell.self)
    // MARK: -Lifecicycle
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .white
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .darkGray
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8 )
        
        addSubview(statusLabel)
        statusLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8 )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func configure(model: UserTask, delegate: ToDoCellDelegate) {
        self.delegate = delegate
        titleLabel.text = model.title
        statusLabel.text = model.state.rawValue
    }
    // MARK: - Selectors
    
    // MARK: - Helpers
    
}


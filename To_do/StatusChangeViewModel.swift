//
//  StatusChangeViewModel.swift
//  To_do
//
//  Created by Catarau, Bianca on 26.04.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol StatusChangeViewModelDelegate: AnyObject {
    func didChangeStatus()
}

class StatusChangeViewModel {
    
    private var userTask: UserTask
    private let db = Firestore.firestore()
    
    weak var delegate: StatusChangeViewModelDelegate?
    
    init(userTask: UserTask, delegate: StatusChangeViewModelDelegate) {
        self.userTask = userTask
        self.delegate = delegate
    }
    
    func setStatus(status: TaskState) {
        let taskId = userTask.id
        let docRef = db.collection("tasks").document(taskId)
        userTask.state = status
        docRef.setData(userTask.dictionary!) { [weak self] error in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didChangeStatus()
        }
    }
}

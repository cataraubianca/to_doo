//
//  CreateToDoViewModel.swift
//  To_do
//
//  Created by Catarau, Bianca on 19.04.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CreateToDoViewModel {
    private let db = Firestore.firestore()
    func createTask(text: String, completion: @escaping (Bool) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        let taskId = UUID().uuidString
        let docRef = db.collection("tasks").document(taskId)
        let model = UserTask.init(id: taskId, title: text, state: .toDo, date: Date(), userId: userId)
        docRef.setData(model.dictionary!) { error in
            if let error = error {
                completion(false)
            } else {
                completion(true)
            }
        }
        
        
    }
    
    
}

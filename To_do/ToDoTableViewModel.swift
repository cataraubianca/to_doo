//
//  ToDoTableViewModel.swift
//  To_do
//
//  Created by Catarau, Bianca on 19.04.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

protocol ToDoTableViewModelDelegate: AnyObject {
    func dataNeedsUpdate()
}

class ToDoTableViewModel {
    private (set) var state = ToDoLoadingState.loading {
        didSet { //se va chema de fiecare data cand se schimba ToDoTableViewModel.state
            delegate?.dataNeedsUpdate()
        }
    }
    weak var delegate: (any ToDoTableViewModelDelegate)?
    private let db = Firestore.firestore()
    func fetchData() {
        state = ToDoLoadingState.loading
        guard let userId = Auth.auth().currentUser?.uid else {
            state = ToDoLoadingState.error(CustomError.userNotFound)
            return
        }
        let docRef = db.collection("tasks")
        docRef.whereField("userId", isEqualTo: userId)
            .getDocuments { [weak self] querySnapshot, error in
                guard let strongSelf = self else { return }
                guard error == nil, let querySnapshot = querySnapshot else {
                    print(error)
                    strongSelf.state = ToDoLoadingState.error(error!)
                    return
                }
                let data = querySnapshot.documents.compactMap { document in
                    let documentData = document.data()
                    do {
                        let json = try JSONSerialization.data(withJSONObject: documentData)
                        let decoder = JSONDecoder()
                        let userTask = try decoder.decode(UserTask.self, from: json)
                        print(userTask)
                        return userTask
                    } catch {
                        return nil
                    }
                }
                strongSelf.state = ToDoLoadingState.dataLoaded(data)
            }
    }
    
   
    
    enum CustomError: Error {
        case firebaseError
        case userNotFound
        var description: String {
            switch self {
            case .userNotFound:
                return "User not found"
            case .firebaseError:
                return "Erro writing task to firebase"
            }
        }
    }
    enum ToDoLoadingState {
        case loading
        case dataLoaded([UserTask])
        case error(Error)
        case empty
    }
    
    func updateState(index: Int) {
        print("index")
    }
    
}

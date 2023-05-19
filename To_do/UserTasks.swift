//
//  UserTasks.swift
//  To_do
//
//  Created by Catarau, Bianca on 19.04.2023.
//

import Foundation

struct UserTask: Codable, Identifiable {
    let id: String
    let title: String
    var state: TaskState
    let date: Date
    let userId: String
}

enum TaskState: String, Codable {
    case toDo = "To do"
    case inProgress = "In progress"
    case done = "Done"
}

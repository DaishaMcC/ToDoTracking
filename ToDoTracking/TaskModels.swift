//
//  TaskModels.swift
//  ToDoTracking
//
//  Created by Daisha McCutcheon on 4/11/26.
//

 // brain where all the logic will be

import Foundation

struct TaskItem: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    var dueDate: Date?
}

struct TaskGroup: Identifiable, Hashable, Codable {
    var id = UUID()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

// add new model
struct Profiles: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var profileImage: String
    var group: [TaskGroup]
}


// pre existing data

extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: "School", symbolName: "book.fill", tasks: [
            TaskItem(title: "Do Homework"),
            TaskItem(title: "Submit assignment", isCompleted: true)
        ]),
        TaskGroup(title: "home", symbolName: "house.fill", tasks: [
            TaskItem(title: "Feed Cats", isCompleted: true),
            TaskItem(title: "Exercixe"),
            TaskItem(title: "Do Chores")
        ])
    ]
}

extension Profiles {
    static let sampleProfile: [Profiles] = [
        Profiles(name: "Professor", profileImage: "professorimg", group: TaskGroup.sampleData),
        Profiles(name: "Student", profileImage: "studentimg", group: [])
    ]
}

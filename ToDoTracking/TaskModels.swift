//
//  TaskModels.swift
//  ToDoTracking
//
//  Created by Daisha McCutcheon on 4/11/26.
//

 // brain where all the logic will be

import Foundation

struct TaskItem: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var isCompleted: Bool = false
    
}

struct TaskGroup: Identifiable, Hashable {
    let id = UUID ()
    var title: String
    var symbolName: String
    var tasks: [TaskItem]
}

// pre existing data

extension TaskGroup {
    static let sampleData: [TaskGroup] = [
        TaskGroup(title: "School", symbolName: "book.fill", tasks: [
            TaskItem(title: "Do Homework"),
            TaskItem(title: "Submit assignment", isCompleted: true)
        ]),
        TaskGroup(title: "home", symbolName: "house.fill", tasks: [
            TaskItem(title: "Buy Groceries")
        ])
    ]
}

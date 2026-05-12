//
//  ToDoTrackingTests.swift
//  ToDoTrackingTests
//
//  Created by Daisha McCutcheon on 4/11/26.
//

import Testing
@testable import ToDoTracking
import Foundation

struct ToDoTrackingTests {

    @Test("Verify that the TaskItem can store and retreieve a due date")
    
    func testTaskItemDueDate(){
        
        let testDate = Date(timeIntervalSince1970: 1735689600)
        let task = TaskItem(title: "Create Test due Date", dueDate: testDate)
        
        #expect(task.dueDate == testDate)
    }

}

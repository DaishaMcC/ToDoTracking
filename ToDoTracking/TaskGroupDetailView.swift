//
//  TaskGroupDetailView.swift
//  ToDoTracking
//
//  Created by Daisha McCutcheon on 4/11/26.
//
//Mark view to show tasks

import SwiftUI

struct TaskGroupDetailView: View {
    
    @Binding var group: TaskGroup
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        
        List{
            Section {
                if sizeClass == .regular {
                    GroupStatsView(tasks: group.tasks)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.systemGroupedBackground))
                }
            }
            ForEach($group.tasks) { $task in
                HStack{
                    Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundStyle(task.isCompleted ? .blue : .gray)
                        .onTapGesture {
                            withAnimation{
                                task.isCompleted.toggle()
                            }
                        }
                    TextField("Task title", text: $task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? .gray : .primary)
                }
                
                HStack{
                    DatePicker("Goal Date", selection : Binding<Date>(
                        get: { task.dueDate ?? Date() },
                        set: {task.dueDate = $0}
                    ), displayedComponents: .date)
                        .labelsHidden()
                        .scaleEffect(0.9)
                        .accessibilityIdentifier("TaskDatePicker")
                    
                    if let due = task.dueDate {
                        Text("Due: \(due.formatted(date:.abbreviated, time:.omitted))")
                            .font(.caption)
                        foregroundColor(.secondary)
                            .accessibilityIdentifier("TaskDateLabel")
                    } else {
                        Text("No Due Date Selected")
                            .font(.caption)
                            .foregroundColor(.blue)
                            .accessibilityIdentifier("TaskDateLabelNotSelected")
                    }
                }
            }
            .onDelete{ index in
                group.tasks.remove(atOffsets: index)
            }
        }
        .navigationTitle(group.title)
        .toolbar{
            Button("Add Task") {
                withAnimation{
                    group.tasks.append(TaskItem(title: ""))
                }
            }
        }
    }
}

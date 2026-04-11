//
//  ContentView.swift
//  ToDoTracking
//
//  Created by Daisha McCutcheon on 4/11/26.
//

//side bar
import SwiftUI

struct ContentView: View {
    @State private var taskGroups = TaskGroup.sampleData //brings in fake information we created taskfile
    @State private var selectedGroup: TaskGroup?
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        // column 1: left
        NavigationSplitView(columnVisibility: $columnVisibility){
            List(selection: $selectedGroup) {
                ForEach(taskGroups) { group in //loops through the element
                    NavigationLink(value: group){ //got to the selected group
                        Label(group.title, systemImage: group.symbolName) // show title and symbol
                    }
                }
            }
            .navigationTitle("ToDo Application")
            .listStyle(.sidebar)
        } detail: {
            
            //Show the selected group found by the index and display it on the detailview
            if let group = selectedGroup {
                if let index = taskGroups.firstIndex(where: {$0.id == group.id}){
                    TaskGroupDetailView(group: $taskGroups[index])
                }
            } else{
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        }
    }
}



//
//  ContentView.swift
//  ToDoTracking
//
//  Created by Daisha McCutcheon on 4/11/26.
//

//side bar
import SwiftUI

struct ContentView: View {
    @State private var taskGroups : [TaskGroup] = [] // no longer calling fake data yay
    @State private var selectedGroup: TaskGroup? // selected group
    @State private var columnVisibility: NavigationSplitViewVisibility = .all // side panel navigation
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "taskGroupData"
    
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
            .toolbar {
                Button {
                    isShowingAddGroup = true
                } label: {
                    Image(systemName: "plus")
                }
            }
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
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { NewGroup in
                taskGroups.append(NewGroup)
                selectedGroup = NewGroup // automatically show details of thhe new group I created
            }
        }
        .onAppear{
            loadData()
        }
        .onChange(of: scenePhase) {oldValue, newValue in
            if newValue == .active {
                print("App Is Active")
            } else if newValue == .inactive {
                print("App is InActive")
            } else if newValue == .background {
                print("Data Is Being Saved")
                saveData()
            }
        }
        
    }
    
    // Data Persistance (save data)
    func saveData() {
        if let encodedData = try? JSONEncoder().encode(taskGroups) {
            //save it in userDefaults
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self,  from: savedData) {
                taskGroups = decodedGroups
                return
            }
        }
        taskGroups = TaskGroup.sampleData // if no data was found to load
    }
}



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
    @Environment(\.dismiss) private var dismiss
    @Binding var profiles: Profiles
    
    var body: some View {
        // column 1: left
        NavigationSplitView(columnVisibility: $columnVisibility){
            List(selection: $selectedGroup) {
                ForEach(profiles.group) { group in //loops through the element
                    NavigationLink(value: group){ //got to the selected group
                        Label(group.title, systemImage: group.symbolName) // show title and symbol
                    }
                }
            }
            .navigationTitle(profiles.name)
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading){
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.purple)
                            .padding(8)
                            .background(Circle().fill(Color.purple.opacity(0.1)))
                    }
                }
                
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityIdentifier("AddGroupButton")
                }
            }
        //    .navigationBarHidden(true)
        } detail: {
            
            //Show the selected group found by the index and display it on the detailview
            if let group = selectedGroup {
                if let index = profiles.group.firstIndex(where: {$0.id == group.id}){
                    TaskGroupDetailView(group: $profiles.group[index])
                }
            } else{
                ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
            }
        }
        .sheet(isPresented: $isShowingAddGroup) {
            NewGroupView { NewGroup in
                profiles.group.append(NewGroup)
                // automatically show details of thhe new group I created
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
        if let encodedData = try? JSONEncoder().encode(profiles.group) {
            //save it in userDefaults
            UserDefaults.standard.set(encodedData, forKey: saveKey)
        }
    }
    
    func loadData() {
        if let savedData = UserDefaults.standard.data(forKey: saveKey) {
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self,  from: savedData) {
                profiles.group = decodedGroups
                return
            }
        }
        profiles.group = TaskGroup.sampleData // if no data was found to load
    }
}



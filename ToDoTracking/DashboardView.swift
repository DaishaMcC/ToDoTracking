//
//  DashboardView.swift
//  ToDoTracking
//
//  Created by Daisha McCutcheon on 4/28/26.
//

import SwiftUI


struct DashboardView: View {
    @State private var profiles: [Profiles] = Profiles.sampleProfile
    @State private var path = NavigationPath()
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        NavigationStack(path: $path){
            ZStack{
                ScrollView{
                    VStack(spacing: 40){
                        Text("Welcome Back")
                            .font(.largeTitle)
                            .textCase(.uppercase)
                            .foregroundColor(.secondary)
                            .padding(.top, 40)
                            .accessibilityIdentifier("Welcome_text")
                        
                        Text("Who is logging in today?")
                            .font(.caption)
                            .accessibilityIdentifier("Welcome_text_subtitle")
                    }
                }
            }
            
            LazyVGrid(columns: columns, spacing: 25){
                ForEach(profiles) { profiles in
                    NavigationLink(value: profiles){
                        VStack{
                                Image(profiles.profileImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(RoundedRectangle(cornerRadius: 22))
                                    .accessibilityIdentifier("ProfileCard_\(profiles.name)")
                                Text(profiles.name)
                                    .font(.system(.headline, design: .rounded))
                                    .fontWeight(.bold)
                        }
                    }
                }
            }
            .navigationTitle("Profile Menu")
            .navigationDestination(for: Profiles.self) { selectedProfiles in
                if let index = profiles.firstIndex(where: {$0.id == selectedProfiles.id}) {
                    ContentView(profiles: $profiles[index])
                }
            }
        }
    }
}

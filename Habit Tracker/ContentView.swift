//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Mehmet Alp Sönmez on 06/06/2024.
//

import SwiftUI

struct ActivityItems: Codable,Identifiable {
    var id = UUID()
    let name: String
    let description: String
    var completetionCounter = 0
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

@Observable
class ActivityList {
    var activities = [ActivityItems]()
    
    init() {
        self.activities = [
        ActivityItems(name: "Guitar", description: "Playing Guitar"),
        ActivityItems(name: "Walking", description: "Morning Walking Activity"),
        ActivityItems(name: "Reading", description: "Reading Books Activity")
        ]
    }
    
    func addNewActivity(name: String, description: String) {
        let newActivity = ActivityItems(name: name, description: description)
        activities.append(newActivity)
    }
}


struct ContentView: View {
    @State private var activityLists = ActivityList()
    @State private var showingAddSheet = false
    
    
    var body: some View {
        NavigationStack {
            List {
                    ForEach(activityLists.activities) { activity in
                        HStack {
                            VStack {
                                Text(activity.name)
                                    .font(.title)
                            }
                            Text(activity.description)
                                .padding(.horizontal)
                        }
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button("Add Habit", systemImage: "plus") {
                    showingAddSheet = true
                }
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            AddHabit(activities: activityLists)
        }
    }
}

#Preview {
    ContentView()
}

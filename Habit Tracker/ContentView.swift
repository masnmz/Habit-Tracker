//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Mehmet Alp Sönmez on 06/06/2024.
//

import SwiftUI

struct ActivityItems: Codable,Identifiable, Hashable, Equatable{
    var id = UUID()
    var name: String
    var description: String
    var completetionCounter = 0
    
    init(name: String, description: String) {
        self.name = name
        self.description = description
    }
}

@Observable
class ActivityList {
    var activities = [ActivityItems]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activities")
            }
        }
    }
    
    init() {
        if let savedActivities = UserDefaults.standard.data(forKey: "Activities") {
            if let decodedActivities = try? JSONDecoder().decode([ActivityItems].self, from: savedActivities) {
                activities = decodedActivities
                return
            }
        }
        activities = []
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
                ForEach(activityLists.activities, id: \.self) { activity in
                    NavigationLink(value: activity){
                        HStack {
                            VStack {
                                Text(activity.name)
                                    .font(.title)
                            }
                            Text(activity.description)
                                .padding(.horizontal)
                            Text("\(activity.completetionCounter)")
                        }
                        .navigationDestination(for: ActivityItems.self) { activity in
                            DetailView(activity: activity, data: activityLists)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .scrollContentBackground(.hidden)
            .background(LinearGradient(colors: [.black, .indigo], startPoint: .topLeading, endPoint: .bottomTrailing))
            .preferredColorScheme(.dark)
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button("Add Habit", systemImage: "plus") {
                    showingAddSheet = true
                }
                EditButton()
            }
        }
        .sheet(isPresented: $showingAddSheet) {
            AddHabit(activities: activityLists)
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activityLists.activities.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}

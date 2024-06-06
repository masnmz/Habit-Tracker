//
//  AddHabit.swift
//  Habit Tracker
//
//  Created by Mehmet Alp Sönmez on 06/06/2024.
//

import SwiftUI

struct AddHabit: View {
    @State private var name = ""
    @State private var description = ""
    @State private var completeCounter = 0
    
    @Environment(\.dismiss) var dismiss
    var activities: ActivityList
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Enter the Name of the Activity Below") {
                    TextField("Name of the activity:", text: $name)
                }
                Section("Enter the Description of the Activity Below") {
                    TextField("Description of the activity:", text: $description)
                }
            }
            .navigationTitle("Add Activity")
            .toolbar {
                Button("Save") {
                    activities.addNewActivity(name: name, description: description)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    AddHabit(activities: ActivityList())
}

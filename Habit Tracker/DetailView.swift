//
//  DetailView.swift
//  Habit Tracker
//
//  Created by Mehmet Alp Sönmez on 06/06/2024.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var activity: ActivityItems
    @State var showAlert = false
    var data: ActivityList
    var body: some View {
        VStack {
            Text(activity.name)
                .font(.largeTitle)
            Text(activity.description)
                .font(.title)
            Text("Completion Count: \(activity.completetionCounter)")
                .font(.title3)
            Button("Tap to Increase Completion Counter") {
                var newActivity = activity
                newActivity.completetionCounter += 1
                
                if let index = data.activities.firstIndex(of: activity) {
                    data.activities[index] = newActivity
                }
                showAlert = true
                dismiss()
      
            }
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .clipShape(Capsule())
            .alert("Counter is increased", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
                    }
            
        }
        .navigationTitle("Activity Details")
        .padding()
    }
}

#Preview {
    var sampleActivity = ActivityItems(name: "Sample", description: "Sample")
    var activityList = ActivityList()
    
    return DetailView(activity: sampleActivity, data: activityList)
}

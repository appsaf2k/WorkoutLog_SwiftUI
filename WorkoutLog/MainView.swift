//
//  ContentView.swift
//  WorkoutLog
//
//  Created by @andreev2k on 22.09.2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var workouts = Workout()
    @State private var showAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts.workout, id: \.id) { item in
                    NavigationLink {
                        List {
                            Text(item.name)
                                .font(.title2.bold())
                            Text(item.descriptions)
                            
                            HStack {
                                Text("Длительность тренировки")
                                Spacer()
                                Text("\(item.time.formatted())  ч.")
                            }
                            
                            HStack {
                                Spacer()
                                Text("\(item.date.formatted(date: .abbreviated, time: .shortened))")
                            }
                        } .listStyle(.inset)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                                    .foregroundColor(colorType(for: item.type))
                            }
                            
                            Spacer()
                            Text("\(item.date.formatted(date: .abbreviated, time: .omitted))")
                        }
                        
                    }
                    
                } .onDelete(perform: removeItem)
            }
            .padding(.top)
            .listStyle(.inset)
            .navigationTitle("Мои тренировки")
            .toolbar {
                EditButton()
                Button {
                    showAddView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddView) {
                AddWorkoutView(workouts: workouts)
            }
        }
    }
    func removeItem(offset: IndexSet) {
        workouts.workout.remove(atOffsets: offset)
    }
    
    func colorType(for type: String) -> Color {
        switch type {
        case "Силовая":
            return .red
        case "Легкая":
            return .secondary
        case "Кардио":
            return .teal
        case "Интервальная":
            return .indigo
        default:
            return .orange
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

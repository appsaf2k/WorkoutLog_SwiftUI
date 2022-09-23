//
//  AddWorkoutView.swift
//  WorkoutLog
//
//  Created by @andreev2k on 22.09.2022.
//

import SwiftUI

struct AddWorkoutView: View {
    @ObservedObject var workouts: Workout
    
    @State private var name = ""
    @State private var description = ""
    @State private var time: Double? = nil
    @State private var date = Date.now
    
    @State private var type = "Легкая"
    var level = ["Силовая", "Легкая", "Объемная", "Интервальная", "Кардио"]
    
    @Environment(\.dismiss) var dismiss
    
    var disabled: Bool {
        name.isEmpty || description.count < 10 || time == nil
    }
    
    @FocusState private var focused: Bool
    
    
    var body: some View {
        NavigationView {
            List {
                TextField("Название", text: $name)
                    .focused($focused)
                
                Picker("Тип тренировки", selection: $type) {
                    ForEach(level, id: \.self) {
                        Text($0)
                    }
                }
                
                Section("Описание тренировки") {
                    TextEditor(text: $description)
                        .frame(height: 300)
                        .focused($focused)
                    
                    TextField("Длительность тренировки", value: $time, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($focused)
                }
                Section("Дата и время") {
                    DatePicker("", selection: $date)
                }
                    
                
            } .navigationTitle("Добавить тренировку")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button("Сохранить") {
                        let workout = WorkoutItem(name: name, descriptions: description, type: type, time: time ?? 0.0, date: date)
                        workouts.workout.append(workout)
                        dismiss()
                    } .disabled(disabled)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Скрыть")  {
                            focused = false
                        }
                    }
                }
        }
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView(workouts: Workout())
    }
}

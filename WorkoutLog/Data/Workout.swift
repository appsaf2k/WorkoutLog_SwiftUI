//
//  WorkOut.swift
//  WorkoutLog
//
//  Created by @andreev2k on 22.09.2022.
//

import Foundation


class Workout: ObservableObject {
    let nameWorkout = "Workout"
    
    @Published var workout = [WorkoutItem]() {
        didSet {
            if let encode = try? JSONEncoder().encode(workout) {
                UserDefaults.standard.set(encode, forKey: nameWorkout)
            }
        }
    }
    
    init() {
        if let savedWorkout = UserDefaults.standard.data(forKey: nameWorkout) {
            if let decodedWorkout = try? JSONDecoder().decode([WorkoutItem].self, from: savedWorkout) {
                workout = decodedWorkout
                return
            }
        }
        workout = []
    }
}

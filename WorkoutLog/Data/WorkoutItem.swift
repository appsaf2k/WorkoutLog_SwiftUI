//
//  WorkoutItem.swift
//  WorkoutLog
//
//  Created by @andreev2k on 22.09.2022.
//

import Foundation

// структура для записи ТРЕНИРОВКИ
struct WorkoutItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let descriptions: String
    let type: String
    let time: Double
    let date: Date
}

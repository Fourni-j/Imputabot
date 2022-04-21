//
//  ImputationType+Extension.swift
//

import Foundation

extension ImputationType {
    var startHour: Int {
        switch self {
        case .sprintPlanning:
            return 10
        case .dsm:
            return 9
        case .grooming(let imputationTime):
            return imputationTime.startHour
        case .teamBuilding:
            return 14
        case .retro:
            return 15
        case .sprintReview:
            return 14
        }
    }

    var startMinutes: Int {
        switch self {
        case .sprintPlanning:
            return 0
        case .dsm:
            return 30
        case .grooming(let imputationTime):
            return imputationTime.startMinute
        case .teamBuilding:
            return 0
        case .retro:
            return 0
        case .sprintReview:
            return 0
        }
    }

    var duration: Int {
        switch self {
        case .sprintPlanning:
            return 5400
        case .dsm:
            return 900
        case .grooming:
            return 1800
        case .teamBuilding:
            return 2700
        case .retro:
            return 3600
        case .sprintReview:
            return 2700
        }
    }

    var issueID: String {
        switch self {
        case .sprintPlanning:
            return "INTERNAL-9965"
        case .dsm:
            return "INTERNAL-9965"
        case .grooming:
            return "INTERNAL-9966"
        case .teamBuilding:
            return "INTERNAL-9967"
        case .retro:
            return "INTERNAL-9965"
        case .sprintReview:
            return "INTERNAL-9965"
        }
    }

    func body(startDate: Date) -> WorkLogEntry {
        let formatter = ISO8601DateFormatter()
        let dateString = formatter.string(from: startDate)
        return WorkLogEntry(started: dateString, timeSpentSeconds: duration, author: WorkLogAuthor(authorId: authorId))
    }
}

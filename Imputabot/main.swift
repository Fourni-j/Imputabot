//
//  main.swift
//

import Foundation

// The first day of the sprint
let sprintStartDate = "2023-01-04T00:00:00+0200"

// Update with your AccountID (Inspect network request to get it)
let authorId = ""

// Update with your own cookie (inspect network request to get it)
let cookies = ""

// Update with the Jira calendar URL
let calendarURL = ""

enum ImputationType {
    case sprintPlanning
    case dsm
    case grooming(ImputationTime)
    case teamBuilding
    case retro
    case sprintReview
}

enum ImputationTime {
    case noon
    case afternoon
}

extension ImputationTime {
    var startHour: Int {
        switch self {
        case .noon:
            return 9
        case .afternoon:
            return 14
        }
    }
    
    var startMinute: Int {
        switch self {
        case .noon:
            return 45
        case .afternoon:
            return 0
        }
    }
}

let calendar: [[ImputationType]] = [
    [.sprintPlanning],              // mercredi
    [.dsm],                         // jeudi
    [.dsm, .teamBuilding],          // vendredi
    [],                             // samedi
    [],                             // dimanche
    [.dsm, .grooming(.afternoon)],  // lundi
    [.dsm],                         // mardi
    [.dsm, .grooming(.noon)],       // mercredi
    [.dsm],                         // jeudi
    [.dsm, .teamBuilding],          // vendredi
    [],                             // Samedi
    [],                             // Dimanche
    [.dsm, .grooming(.afternoon)],  // lundi
    [.dsm],                         // mardi
]

func jiraWorklogRequest(_ imputationType: ImputationType, _ startDate: Date) -> URLRequest {
    var request = URLRequest(url: URL(string: calendarURL)!)
    
    // Add headers
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("com.jiraworkcalendar.work-calendar", forHTTPHeaderField: "ap-client-key")
    request.addValue(cookies, forHTTPHeaderField: "Cookie")
    request.httpMethod = "POST"
    request.httpBody = try? JSONEncoder().encode(imputationType.body(startDate: startDate))
    
    return request
}


guard let sprintStartDate: Date = ISO8601DateFormatter().date(from: sprintStartDate) else {
    exit(-1)
}

let dateComponentFormatter = DateComponentsFormatter()

calendar.enumerated().forEach { index, imputations in
    imputations.forEach { imputationType in
        guard let computedDate = dateComponentFormatter.calendar?.date(byAdding: DateComponents(day: index, hour: imputationType.startHour, minute: imputationType.startMinutes), to: sprintStartDate) else { return }
        print("Request for \(String(describing: imputationType)) at \(computedDate) for \(imputationType.duration / 60) min on issue \(imputationType.issueID)")
        let request = jiraWorklogRequest(imputationType, computedDate)
        let task = URLSession.shared.dataTask(with: request) { responseData, response, error in
            print("\(String(describing: response)) - \(String(describing: error))")
        }
        // Comment this line to run dry (only logs will be printed, no requests done)
        task.resume()
    }
}

struct WorkLogEntry: Codable {
    let started: String
    let timeSpentSeconds: Int
    let author: WorkLogAuthor
}

struct WorkLogAuthor: Codable {
    let authorId: String
}

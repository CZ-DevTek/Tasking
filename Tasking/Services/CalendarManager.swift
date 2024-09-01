//
//  CalendarManager.swift
//  Tasking
//
//  Created by Carlos Garcia Perez on 1/9/24.
//

import EventKit

class CalendarManager {
    private let eventStore = EKEventStore()
    
    func requestAccess(completion: @escaping (Bool) -> Void) {
        eventStore.requestFullAccessToEvents { granted, _ in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func createEvent(for task: Task, completion: @escaping (Result<Void, Error>) -> Void) {
        let startDate = Date()
        let endDate = Calendar.current.date(byAdding: .hour, value: 1, to: startDate) ?? startDate
        
        let event = EKEvent(eventStore: eventStore)
        event.title = task.name
        event.startDate = startDate
        event.endDate = endDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        do {
            try eventStore.save(event, span: .thisEvent)
            completion(.success(()))
        } catch {
            completion(.failure(error))
        }
    }
}

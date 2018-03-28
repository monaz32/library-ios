//
//  EventAPICallExamples.swift
//  Library
//
//  Created by Alumina on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

class EventAPICallExamples {
    
    // get all events
    // note: getCurrentEvents, getPastEvents, getEventsWithLocation are similar
    func getEvents() {
        EventService.sharedService.getEvents { (result) in
            switch result {
            case .success:
                print("getEvents success")
                
                let events = result.value!
                for event in events {
                    print("\(event.name as String?)")
                }
            case .failure:
                print("getEvents failure")
            }
        }
    }
    
    // add a new event
    func addEvent() {
        EventService.sharedService.addEvent(name: "Test Event", branchNum: 3, fromTime: "9:00", toTime: "11:00", fromDate: "03/27/18", toDate: "03/27/18") { (result) in
            switch result {
            case .success:
                print("addEvent success")
            case .failure:
                print("addEvent failure")
            }
        }
    }
    
    // get event based on id
    func getEventFromID() {
        EventService.sharedService.getEventFromID(id: "1000") { (result) in
            switch result {
            case .success:
                print("getEventFromID success")
                
                let event = result.value!
                print(event.name!)
            case .failure:
                print("getEventFromID failure")
            }
        }
    }
    
    // delete event given an event id
    func deleteEvent() {
        EventService.sharedService.deleteEvent(id: "2001") { (result) in
            switch result {
            case .success:
                print("deleteEvent success")
            case .failure:
                print("deleteEvent failure")
            }
        }
    }
    
    func getEventsWithLocationFromBranchName() {
        EventService.sharedService.getEventsWithLocationFromBranchName(name: "Renfrew") { (result) in
            switch result {
            case .success:
                print("getEventsWithLocationFromBranchName success")
                
                let events = result.value!
                for event in events {
                    print("\(event.eventName as String?): \(event.fromTime as String?)")
                }
                
            case .failure:
                print("getEventsWithLocationFromBranchName failure")
            }
        }
    }
}

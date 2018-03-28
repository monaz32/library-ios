//
//  EventService.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-27.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class EventService {
    static let sharedService = EventService()
    
    // get details on all events
    func getEvents(completion: @escaping (Result<[Event]>) -> Void) {
        APIClient.sharedClient.request(Router.getEvents) { (response) in
            self.listEventHandler(response: response, completion: completion)
        }
    }
    
    // add a new event
    func addEvent(name: String, branchNum: Int, fromTime: String, toTime: String, fromDate: String, toDate: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addEvent(name: name, branchNum: branchNum, fromTime: fromTime, toTime: toTime, fromDate: fromDate, toDate: toDate)) { (response) in
            APIClient.sharedClient.checkSuccessHandler(response: response, completion: completion)
        }
    }
    
    // get all ongoing and future events
    func getCurrentEvents(completion: @escaping (Result<[Event]>) -> Void) {
        APIClient.sharedClient.request(Router.getCurrentEvents) { (response) in
            self.listEventHandler(response: response, completion: completion)
        }
    }
    
    // get all past events
    func getPastEvents(completion: @escaping (Result<[Event]>) -> Void) {
        APIClient.sharedClient.request(Router.getPastEvents) { (response) in
            self.listEventHandler(response: response, completion: completion)
        }
    }
    
    // get event with id
    func getEventFromID(id: String, completion: @escaping (Result<Event>) -> Void) {
        APIClient.sharedClient.request(Router.getEventFromID(id: id)) { (response) in
            switch response {
            case .success(let result):
                if let json = result as? [[String: Any]] {
                    let events = Mapper<Event>().mapArray(JSONArray: json)
                    // There is only one event with the corresponding id, so we return
                    // the first element of the array.
                    completion(Result.success(events[0]))
                }
                else {
                    completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
                }
                
            case .failure(let error):
                completion(Result.failure(error))
            }
        }
    }
    
    func deleteEvent(id: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.deleteEvent(id: id)) { (response) in
            APIClient.sharedClient.checkSuccessHandler(response: response, completion: completion)
        }
    }
    
    // get details on all events with their locations
    func getEventsWithLocation(completion: @escaping (Result<[EventWithLocation]>) -> Void) {
        APIClient.sharedClient.request(Router.getEventsWithLocation) { (response) in
            self.listEventWithLocationHandler(response: response, completion: completion)
        }
    }
    
    // get details on all events at specific branch
    func getEventsWithLocationFromBranchName(name: String, completion: @escaping (Result<[EventWithLocation]>) -> Void) {
        APIClient.sharedClient.request(Router.getEventsWithLocationFromBranchName(name: name)) { (response) in
            self.listEventWithLocationHandler(response: response, completion: completion)
        }
    }
    
    
    // Utilities
    func listEventHandler(response: Result<Any>, completion: @escaping (Result<[Event]>) -> Void) {
        switch response {
        case .success(let result):
            if let json = result as? [[String: Any]] {
                let events = Mapper<Event>().mapArray(JSONArray: json)
                completion(Result.success(events))
            }
            else {
                completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
            }
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
    
    func listEventWithLocationHandler(response: Result<Any>, completion: @escaping (Result<[EventWithLocation]>) -> Void) {
        switch response {
        case .success(let result):
            if let json = result as? [[String: Any]] {
                let events = Mapper<EventWithLocation>().mapArray(JSONArray: json)
                completion(Result.success(events))
            }
            else {
                completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
            }
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

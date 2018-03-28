//
//  ScheduleService.swift
//  Library
//
//  Created by Mona Zhao on 2018-03-28.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class ScheduleService {
    static let sharedService = ScheduleService()
    
    // get details on all room bookings
    func getSchedules(completion: @escaping (Result<[Schedule]>) -> Void) {
        APIClient.sharedClient.request(Router.getSchedules) { (response) in
            self.listResultHandler(response: response, completion: completion)
        }
    }
    
    // add a room booking
    func addSchedule(accountID: Int, roomName: String, fromTime: String, fromDate: String, toTime: String, toDate: String, completion: @escaping (Result<Bool>) -> Void) {
        APIClient.sharedClient.request(Router.addSchedule(accountID: accountID, roomName: roomName, fromTime: fromTime, fromDate: fromDate, toTime: toTime, toDate: toDate)) { (response) in
            APIClient.sharedClient.checkSuccessHandler(response: response, completion: completion)
        }
    }
    
    // get all room bookings by a member
    func getSchedulesWithAccountID(id: Int, completion: @escaping (Result<[Schedule]>) -> Void) {
        APIClient.sharedClient.request(Router.getSchedulesWithAccountID(id: id)) { (response) in
            self.listResultHandler(response: response, completion: completion)
        }
    }
    
    // get all bookings of a room
    func getSchedulesWithRoomName(name: String, completion: @escaping (Result<[Schedule]>) -> Void) {
        APIClient.sharedClient.request(Router.getSchedulesWithRoomName(name: name)) { (response) in
            self.listResultHandler(response: response, completion: completion)
        }
    }
    
    
    // Utilities
    func listResultHandler(response: Result<Any>, completion: @escaping (Result<[Schedule]>) -> Void) {
        switch response {
        case .success(let result):
            if let json = result as? [[String: Any]] {
                let results = Mapper<Schedule>().mapArray(JSONArray: json)
                completion(Result.success(results))
            }
            else {
                completion(Result.failure(ServiceError.CastFailure("Result casting failed.")))
            }
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

//
//  APIClient.swift
//  Library
//
//  Created by Paco Lee on 2018-03-25.
//  Copyright © 2018 Paco Lee. All rights reserved.
//

import Alamofire

enum ServiceError: Error {
    case CastFailure(String)
}

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://localhost:8080"
    
    //Book
    case getBooks(title: String, author: String, publisher: String, genre:String) //
    case addBook(isbn: String, title: String, author: String, publisher: String, genre: String)
    case getBook(isbn: String)
    case updateBook(isbn: String, title: String, author: String, publisher: String, genre: String)
    case deleteBook(isbn: String)
    case getBookGenreCount
    
    // Employee
    case getEmployees
    case addEmployee(email: String, sin: String, name: String, address: String, phoneNumber: String, branchNumber: Int,
        adminStatus: Bool, password: String)
    case getEmployee(id: String)
    case updateEmployee(id: String, email: String, address: String, phoneNumber: String, password: String)
    case getEmployeeFromName(name: String)
    case employeeLogin(email: String, password: String)

    //Member
    case getMembers
    case addMember(phoneNum: String, email: String, name: String, password: String) //
    case getMember(id: Int)
    case updateMember(id: Int, phoneNum: String, fines: String, password: String)
    case memberLogin(email: String, password: String) //
    case calcFines
    
    // Event
    case getEvents
    case addEvent(name: String, branchNum: Int, fromTime: String, toTime: String, fromDate: String, toDate: String)
    case getCurrentEvents
    case getPastEvents
    case getEventFromID(id: String)
    case deleteEvent(id: String)
    case getEventsWithLocation
    case getEventsWithLocationFromBranchName(name: String)
    
    // Rental
    case getCurrentRentalsOfMember(id: Int)
    case addRental(memberID: Int, bookID: Int, fromTime: String, fromDate: String)
    case returnRental(bookID: Int, returnTime: String, returnDate: String)
    
    // Library Book
    case addLibraryBook(isbn: String, branchNum: Int)
    case getLibraryBooks(branchNum: Int, status: Bool)
    case getLibraryBook(id: Int)
    case deleteLibraryBook(id: Int)
    
    // Rating
    case getMAXRating
    case getMINRating
    case getAVRRating(isbn: String)
    
    // Review
    case getReviews(isbn: String)
    case addReview(isbn: String, accountID: Int, rating: Int, review: String)

    var method: HTTPMethod {
        switch self {
        case .addBook, .getBooks,
             .addEmployee, .employeeLogin,
             .addMember, .memberLogin,
             .addEvent,
             .addRental,
             .addLibraryBook, .getLibraryBooks,
             .addReview:
            return .post
            
        case .getBook, .getBookGenreCount,
             .getEmployees, .getEmployee, .getEmployeeFromName,
             .getMembers, .getMember,
             .getEvents, .getCurrentEvents, .getPastEvents, .getEventFromID, .getEventsWithLocation, .getEventsWithLocationFromBranchName,
             .getCurrentRentalsOfMember,
             .getLibraryBook,
             .getMAXRating, .getMINRating, .getAVRRating,
             .getReviews:
            return .get
            
        case .updateBook,
             .updateMember, .calcFines,
             .updateEmployee,
             .returnRental:
            return .put
            
        case .deleteBook,
             .deleteEvent,
             .deleteLibraryBook:
            return .delete
        }
    }
    
    var path: String {
        switch self {
        // Book
        case .addBook, .getBook, .updateBook, .deleteBook:
            return "/book"
        case .getBooks:
            return "/book/filter"
        case .getBookGenreCount:
            return "/book/genrecount"

        // Member
        case .getMembers, .addMember:
            return "/member"
        case .getMember, .updateMember:
            return "/member/id"
        case .memberLogin:
            return "/member/login"
        case .calcFines:
            return "/member/fines"

        // Employee
        case .getEmployees, .addEmployee:
            return "/employee"
        case .employeeLogin:
            return "/employee/login"
        case .getEmployee, .updateEmployee:
            return "/employee/id"
        case .getEmployeeFromName:
            return "/employee/name"
            
        // Event
        case .getEvents, .addEvent:
            return "/event"
        case .getCurrentEvents:
            return "/event/current"
        case .getPastEvents:
            return "/event/past"
        case .getEventFromID, .deleteEvent:
            return "/event/id"
        case .getEventsWithLocation, .getEventsWithLocationFromBranchName:
            return "/event/location"
            
        // Rental
        case .getCurrentRentalsOfMember, .addRental:
            return "/rental"
        case .returnRental:
            return "/rental/return"
            
        // Library Book
        case .addLibraryBook, .getLibraryBook, .deleteLibraryBook:
            return "/librarybook"
        case .getLibraryBooks:
            return "/librarybook/filter"
            
        // Rating
        case .getMAXRating:
            return "/rating/max"
        case .getMINRating:
            return "/rating/min"
        case .getAVRRating:
            return "/rating"
            
        // Review
        case .getReviews, .addReview:
            return "/review"
        }
    }
    
    // MARK: URLRequestConvertible
    
    func asURLRequest() throws -> URLRequest {
        let url = try Router.baseURLString.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        // Book
        case .getBooks(let title, let author, let publisher, let genre):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["title": title, "author": author, "publisher": publisher, "genre": genre])
        case .addBook(let isbn, let title, let author, let publisher, let genre):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["isbn": isbn, "title": title, "author": author, "publisher": publisher, "genre": genre])
        case .getBook(let isbn):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(isbn)")
        case .updateBook(let isbn, let title, let author, let publisher, let genre):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["isbn": isbn, "title": title, "author": author, "publisher": publisher, "genre": genre])
        case .deleteBook(let isbn):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(isbn)")
        case .getBookGenreCount:
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)")
            
        // Member
        case .addMember(let phoneNum, let email, let name, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["phoneNum": phoneNum, "email": email, "name": name, "password": password])
        case .getMember(let id):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(id)")
        case .updateMember(let id, let phoneNum, let fines, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["id": id, "phoneNum": phoneNum, "fines": fines, "password": password])
        case .memberLogin(let email, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email": email, "password": password])

        // Employee
        case .addEmployee(let email, let sin, let name, let address, let phoneNumber, let branchNumber, let adminStatus, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email": email, "sin": sin, "name": name, "address": address, "phoneNum": phoneNumber, "branch": branchNumber, "admin": adminStatus,
                "password": password])
        case .getEmployee(let id):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(id)")
        case .updateEmployee(let id, let email, let address, let phoneNumber, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email": email, "address": address, "phoneNum": phoneNumber, "password": password])
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(id)")
        case .getEmployeeFromName(let name):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(name)")
        case .employeeLogin(let email, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email": email, "password": password])
            
        // Event
        case .addEvent(let name, let branchNum, let fromTime, let toTime, let fromDate, let toDate):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["name": name, "branchNum": branchNum, "fromTime": fromTime, "toTime": toTime, "fromDate": fromDate, "toDate": toDate])
        case .getEventFromID(let id), .deleteEvent(let id):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(id)")
        case .getEventsWithLocationFromBranchName(let name):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(name)")
            
        // Rental
        case .getCurrentRentalsOfMember(let id):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(id)")
        case .addRental(let memberID, let bookID, let fromTime, let fromDate):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["bookID": bookID, "fromTime": fromTime, "fromDate": fromDate])
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(memberID)")
        case .returnRental(let bookID, let returnTime, let returnDate):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["bookID": bookID, "returnTime": returnTime, "returnDate": returnDate])
            
        // Library Book
        case .addLibraryBook(let isbn, let branchNum):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["isbn": isbn, "branchNum": branchNum])
        case .getLibraryBooks(let branchNum, let status):
            status ? print("true\n") : print("false")
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["branchNum": branchNum, "status": status ? 1 : 0])
        case .getLibraryBook(let id), .deleteLibraryBook(let id):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(id)")
            
        // Rating
        case .getAVRRating(let isbn):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(isbn)")
            
        // Review
        case .getReviews(let isbn):
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(isbn)")
        case .addReview(let isbn, let accountID, let rating, let review):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["accountID": accountID, "rating": rating, "review": review])
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)/\(isbn)")
            
        default:
            break
        }
        
        return urlRequest
    }
}

class APIClient {
    
    static let sharedClient = APIClient()
    
    private let sessionManager: SessionManager
    
    init() {
        var defaultHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        defaultHeaders["Content-Type"] = ""
        defaultHeaders["Accept"] = "application/json"
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = defaultHeaders
        
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func request(_ request: URLRequestConvertible, completion: @escaping (Result<Any>) -> Void) {
        sessionManager.request(request).validate().responseJSON { (response) in
            completion(response.result)
        }
    }
    
    func download(_ request: URLRequestConvertible, completion: @escaping (Result<Data>) -> Void) {
        sessionManager.download(request).validate().responseData{ response in
            completion(response.result)
        }
    }
    
    func upload(_ data: Data, fileName: String, mimeType: String, _ request: URLRequestConvertible, completion: @escaping (Result<Any>) -> Void) {
        sessionManager.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "file", fileName: fileName, mimeType: mimeType)
        },
            with:  request,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        completion(Result.success(response.result))
                    }
                case .failure(let encodingError):
                    completion(Result.failure(encodingError))
                }
        }
        )
    }
    
    
    // Utilities
    func checkSuccessHandler(response: Result<Any>, completion: @escaping (Result<Bool>) -> Void) {
        switch response {
        case .success:
            completion(Result.success(true))
        case .failure(let error):
            completion(Result.failure(error))
        }
    }
}

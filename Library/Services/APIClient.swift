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
    
    // Book
    case getBooks(title: String, author: String, publisher: String, genre:String)
    case addBook(isbn: String, title: String, author: String, publisher: String, genre: String)
    case getBook(isbn: String)
    case updateBook(isbn: String, title: String, author: String, publisher: String, genre: String)
    case deleteBook(isbn: String)
    case getBookGenreCount
    
    // Employee
    case getEmployees
    case addEmployee(email: String, sin: String, name: String, address: String, phoneNumber: String, branchNumber: Int,
        adminStatus: Bool, password: String)
    case employeeLogin(email: String, password: String)

    var method: HTTPMethod {
        switch self {
        case .addBook, .getBooks,
             .addEmployee, .employeeLogin:
            return .post
        case .getBook, .getBookGenreCount,
             .getEmployees:
            return .get
        case .updateBook:
            return .put
        case .deleteBook:
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
            
        // Employee
        case .getEmployees, .addEmployee:
            return "/employee"
        case .employeeLogin:
            return "/employee/login"
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
            
        // Employee
        case .getEmployees:
            urlRequest.url = URL(string: "\(Router.baseURLString)\(path)")
        case .addEmployee(let email, let sin, let name, let address, let phoneNumber, let branchNumber, let adminStatus, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email": email, "sin": sin, "name": name, "address": address, "phoneNum": phoneNumber, "branch": branchNumber, "admin": adminStatus,
                "password": password])
        case .employeeLogin(let email, let password):
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: ["email": email, "password": password])
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
}

//
//  Endpoint.swift
//  FetchRewardsCodingExercise
//
//  Created by Vandan Patel on 11/17/20.
//

import Foundation

enum RequestType: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var requestType: RequestType { get }
    
    var buildRequest: URLRequest? { get }
}

enum ItemsListAPI {
    case fetchItems
}

extension ItemsListAPI: Endpoint {
    var baseURL: String {
        switch self {
        case .fetchItems:
            return "https://fetch-hiring.s3.amazonaws.com/"
        }
    }
    
    var path: String {
        switch self {
        case .fetchItems:
            return "hiring.json"
        }
    }
    
    var requestType: RequestType {
        switch self {
        case .fetchItems:
            return .get
        }
    }
    
    var buildRequest: URLRequest? {
        guard let url = URL(string: baseURL + path) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = requestType.rawValue
        return request
    }
    
}

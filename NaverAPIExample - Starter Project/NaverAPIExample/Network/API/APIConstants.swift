//
//  APIConstants.swift
//  NaverAPIExample
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 codershigh. All rights reserved.
//

import Foundation

// 1. API 상수들을 모아두는 곳
public struct APIConstants {
    public static let baseURL: String = ""
    
    public enum Endpoints: String {
        case sample = ""
    }
    
    public enum HTTPMethod: String {
        case GET
        case POST
        case PUT
        case DELETE
    }
    
    public struct Headers {
        public static var contentTypeKey = "Content-Type"
        public static var contentTypeValue = "application/json"
    }
    
    public static func getEndpointURLString(endpoint: Endpoints) -> String {
        return baseURL + endpoint.rawValue
    }
}

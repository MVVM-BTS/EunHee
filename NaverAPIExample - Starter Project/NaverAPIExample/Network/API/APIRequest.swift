//
//  APIRequest.swift
//  NaverAPIExample
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 codershigh. All rights reserved.
//

import Foundation

// 2. API Request 보낼 때 필요한 함수들을 모아두는 곳
public protocol APIRequestProtocol {
    associatedtype APIRequestParametersType // 보통은 String, Any 가 들어감
    func createRequest(with parameters: APIRequestParametersType) -> URLRequest? // 필요한 파라미터 넣어서 url request 생성
}

public extension APIRequestProtocol {
    // 바디
    func setBodyParameters(parameters: [String:Any], urlRequest: inout URLRequest) {
        guard !parameters.isEmpty else { Log.event(type: .error, "파라미터가 없습니다...!")
            return
        }
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            urlRequest.httpBody = jsonData
        }
    }
    
    // 쿼리
    func setQueryParameters(parameters: [String:Any], url: URL) -> URL {
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = parameters.map { element in URLQueryItem(name: element.key, value: String(describing: element.value)) }
        return components?.url ?? url
    }
    
    // 헤더
    func setDefaultHeaders(request: inout URLRequest) {
        request.setValue(APIConstants.Headers.contentTypeValue, forHTTPHeaderField: APIConstants.Headers.contentTypeKey)
    }
}


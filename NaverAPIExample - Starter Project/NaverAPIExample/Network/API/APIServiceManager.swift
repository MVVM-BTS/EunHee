//
//  APIServiceManager.swift
//  NaverAPIExample
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 codershigh. All rights reserved.
//

import Foundation

typealias APIService = APIRequestProtocol & APIResponseProtocol // 모든 서비스 파일이 Request, Response 가능하도록 묶어주었음

class APIServiceManager <T: APIService> {
    public let service: T
    public let urlSession: URLSession
    
    public init(service: T, urlSession: URLSession = .shared) {
        self.service = service
        self.urlSession = urlSession
    }
    
    // API 요청을 수행하는 함수
    public func performAPIRequest(with requestParameters: T.APIRequestParametersType, completionHandler: @escaping (T.APIResponseDataType?, Error?) -> ()) {
        // 제너럴 타입의 파라미터를 넣어 보냄
        // 탈출 클로저 형태로 응답 데이터(제너럴 타입) 혹은 오류를 받아옴
        
        if let urlRequest = service.createRequest(with: requestParameters) {
            Log.event(type: .api, "API 요청 메서드 초기화: \(urlRequest.httpMethod ?? "GET") -> Endpoint: \(urlRequest.url!.absoluteString)")
            urlSession.dataTask(with: urlRequest) { data, response, error in
                guard let data = data,
                      let httpResponse = response as? HTTPURLResponse
                else {
                    Log.event(type: .error, "유효한 HTTP 응답 혹은 데이터를 받지 못했어요!")
                    return completionHandler(nil, error)
                }
                do {
                    let parsedResponse = try self.service.parseResponse(data: data, response: httpResponse)
                    completionHandler(parsedResponse, nil)
                }
                catch {
                    completionHandler(nil, error)
                }
            }.resume()
        }
    }
}

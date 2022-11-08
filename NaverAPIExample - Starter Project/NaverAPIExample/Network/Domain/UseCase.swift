//
//  UseCase.swift
//  NaverAPIExample
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 codershigh. All rights reserved.
//

import Foundation

struct MovieSearchService: APIService {
    typealias APIRequestParametersType = [String: Any]
    
    func createRequest(with parameters: [String : Any]) -> URLRequest? {
        let urlString = APIConstants.getEndpointURLString(endpoint: .sample)
        if var url = URL(string: urlString) {
            if !parameters.isEmpty {
                url = setQueryParameters(parameters: parameters, url: url)
            }
            var urlRequest = URLRequest(url: url)
            setDefaultHeaders(request: &urlRequest)
            urlRequest.httpMethod = APIConstants.HTTPMethod.GET.rawValue
            return urlRequest
        }
        return nil
    }
    
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> Movie {
        return try defaultParsedResponse(data: data, response: response)
    }
}

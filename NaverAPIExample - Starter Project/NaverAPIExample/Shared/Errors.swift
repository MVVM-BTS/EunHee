//
//  Shared.swift
//  NaverAPIExample
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 codershigh. All rights reserved.
//

import Foundation

public enum CustomError: Error {
    case decodingUnknown(source: String)
    case api(type: APIError)
    case validation(type: ValidationError)
    case search(type: SearchError)
    
    public enum APIError {
        case clientError(code: Int, endpoint: String, parameters: String)
        case serverError(code: Int, endpoint: String, parameters: String)
    }
    public enum ValidationError {
        case isEmpty(field: String)
    }
    public enum SearchError {
        case notFound
    }
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingUnknown(source: let filename):
            return NSLocalizedString("bundle로부터 \(filename).json 해독 실패", comment: "알 수 없는 error")
        case .validation(type: let type):
            switch type {
            case .isEmpty(field: let fieldName):
                return NSLocalizedString("\(fieldName)은 비워둘 수 없습니다.", comment: "")
            }
            
        case .api(type: let type):
            switch type {
            case .clientError(code: let code, endpoint: let endpoint, parameters: let parameters):
                return NSLocalizedString("요청 중 발생한 APIError: \(endpoint), 파라미터 (\(parameters), 상태코드 \(code)", comment: "")
            case .serverError(code: let code, endpoint: let endpoint, parameters: let parameters):
                return NSLocalizedString("수행 중 발생한 APIError: \(endpoint), 파라미터 (\(parameters), 상태코드 \(code)", comment: "")
            }
            
        case .search(type: let type):
            switch type {
            case .notFound:
                return NSLocalizedString("검색 결과 없음", comment: "")
            }
        }
    }
}

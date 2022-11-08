//
//  APIResponse.swift
//  NaverAPIExample
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 codershigh. All rights reserved.
//

import Foundation

// 3. 응답받은 결과를 해독 및 파싱하는 곳
public protocol APIResponseProtocol {
    associatedtype APIResponseDataType // 데이터 모델이 채택할 타입
    func parseResponse(data: Data, response: HTTPURLResponse) throws -> APIResponseDataType
}

public extension APIResponseProtocol {
    func defaultParsedResponse<T: Decodable>(data: Data, response: HTTPURLResponse) throws -> T {
        let jsonDecoder = JSONDecoder()
        do {
            let body = try jsonDecoder.decode(T.self, from: data)
            
            switch response.statusCode {
            case 200..<300:
                Log.event(type: .api, "성공적인 응답, 상태코드: \(response.statusCode) -> 파싱: \(T.self)")
                return body
            case 400..<500:
                Log.event(type: .error, "응답 실패 (.clientError), 상태코드: \(response.statusCode)")
                throw CustomError.api(type: .clientError(code: response.statusCode, endpoint: response.url!.absoluteString, parameters: ""))
            case 500..<600:
                Log.event(type: .error, "응답 실패 (.serverError), 상태코드: \(response.statusCode)")
                throw CustomError.api(type: .serverError(code: response.statusCode, endpoint: response.url!.absoluteString, parameters: ""))
            default:
                Log.event(type: .error, "응답 실패 (.serverError), 상태코드: \(response.statusCode)")
                throw CustomError.api(type: .serverError(code: response.statusCode, endpoint: response.url!.absoluteString, parameters: ""))
            }
        } catch {
            Log.event(type: .error, "\(T.self)로 파싱 실패")
            throw CustomError.decodingUnknown(source: data.debugDescription)
        }
    }
}

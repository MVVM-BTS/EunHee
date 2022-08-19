//
//  Entity.swift
//  MVVM-Final
//
//  Created by 정은희 on 2022/08/19.
//

import Foundation

// Entity에 해당하는 부분

struct UTCTimeModel: Codable {
    let id: String
    let currentDateTime: String
    let utcOffset: String
    let isDayLightSavingsTime: Bool
    let dayOfTheWeek: String
    let timeZoneName: String
    let currentFileTime: Int
    let ordinalDate: String
    let serviceResponse: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "$id"
        case currentDateTime, utcOffset, isDayLightSavingsTime, dayOfTheWeek,
             timeZoneName, currentFileTime, ordinalDate, serviceResponse
    }
}

//
//  Logger.swift
//  NaverAPIExample
//
//  Created by 정은희 on 2022/11/08.
//  Copyright © 2022 codershigh. All rights reserved.
//

import Foundation

public enum LogEvent: String {
    case error = "[❌❌ ERROR ❌❌]"
    case info = "[👀🔎 INFO 🔎👀]"
    case warning = "[😱😱 WARNING 😱😱]"
    case api = "[📡📡 API 📡📡]"
}

public func print(_ object: Any) {
    #if DEBUG // 디버깅 할 때만 동작하도록
    Swift.print(object)
    #endif
}

public class Log {
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    private static var isLoggingEnabled: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    public class func event(type: LogEvent, _ object: Any, filename: String = #file, line: Int = #line, column: Int = #column, funcName: String = #function) {
        if isLoggingEnabled {
            var eventPrefix = ""
            switch type {
            case .error:
                eventPrefix = LogEvent.error.rawValue
            case .info:
                eventPrefix = LogEvent.info.rawValue
            case .warning:
                eventPrefix = LogEvent.warning.rawValue
            case .api:
                eventPrefix = LogEvent.api.rawValue
            }
            print("\(Date().toString()) \(eventPrefix) [\(sourceFileName(filePath: filename))]: line: \(line) column:\(column) \(funcName) -> \(object)\n")
        }
    }
    // 파일의 경로로부터 (번들 내의) 파일명을 추출하는 부분
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

fileprivate extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
}

//
//  Logic.swift
//  MVVM-Final
//
//  Created by 정은희 on 2022/08/19.
//

import Foundation

// Logic에 해당하는 부분

class Service {
    // MARK: - Fetch
    let repository = Repository()
    
    var currentModel = Model(currentDateTime: Date()) // 현재 자신(= Service)이 서비스하고 있는 Model을 알아야 하므로
    
    func fetchNow(onCompleted: @escaping (Model) -> Void) {
        // Entity -> Model
        repository.fetchNow { entity in
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm'Z'"
            
            guard let now = formatter.date(from: entity.currentDateTime)
            else { return }
            let model = Model(currentDateTime: now)
            self.currentModel = model
            
            onCompleted(model)
        }
    }
    
    func moveDay(day: Int) {
        guard let moveDay = Calendar.current.date(byAdding: .day,
                                                    value: day,
                                                    to: currentModel.currentDateTime)
        else { return }
        currentModel.currentDateTime = moveDay
    }
}

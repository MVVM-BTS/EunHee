//
//  ViewModel.swift
//  MVVM-Final
//
//  Created by 정은희 on 2022/08/19.
//

import Foundation

import RxRelay

class ViewModel {
    let dateTimeString = BehaviorRelay(value: "Loading...") // 변형이 일어나는 부분

    let service = Service()
    
    func viewDidLoad() {
        service.fetchNow { [weak self] model in
            guard let self = self else { return }
            let dateString = self.dateToString(date: model.currentDateTime)
            self.dateTimeString.accept(dateString)  // accpet로 값 넣어줌
        }
    }
    
    func dateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일 HH시 mm분"
        return formatter.string(from: date)
    }
    
    func moveDay(day: Int) {
        service.moveDay(day: day)
        dateTimeString = dateToString(date: service.currentModel.currentDateTime)
    }
    
    func reload() {
        viewDidLoad()
    }
}

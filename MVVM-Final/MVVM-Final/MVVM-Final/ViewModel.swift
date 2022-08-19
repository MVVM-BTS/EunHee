//
//  ViewModel.swift
//  MVVM-Final
//
//  Created by 정은희 on 2022/08/19.
//

import Foundation



class ViewModel {
    var onUpdate: () -> Void = {}
    var dateTimeString: String = "Loading..."   // 화면에 보여줄 값 (== View를 위한 Model == ViewModel)
    {
        didSet {
            onUpdate()
        }
        
        // UI Thread를 처리하는 부분은 뷰모델에서 업데이트 해줄 때 해줘야함 ↓
        // 하지만 뷰모델은 UIKit과 관련없는 부분이므로 VC에서 비동기로 처리해줌
//        didSet {
//            DispatchQueue.main.async {
//                onUpdate()
//            }
//        }
    }
    let service = Service()
    
    func viewDidLoad() {
        service.fetchNow { [weak self] model in
            guard let self = self else { return }
            let dateString = self.dateToString(date: model.currentDateTime)
            self.dateTimeString = dateString
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

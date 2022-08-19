//
//  ViewController.swift
//  MVVM-Final
//
//  Created by 정은희 on 2022/08/19.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    // 이벤트 발생
    @IBAction func onYesterday() {
        viewModel.moveDay(day: -1)
    }
    @IBAction func onNow() {
        dateTimeLabel.text = "Loading..."
        viewModel.reload()  // fetch
    }
    @IBAction func onTomorrow() {
        viewModel.moveDay(day: +1)
    }
    
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension ViewController {
    private func bind() {
        // upDate 되면 처리해주는 부분 (이해 덜 됨)
        viewModel.dateTimeString    // viewModel의 dateTimeString에 변화가 일어나면
        /*
            .observe(on: MainScheduler.instance)    // 메인스케줄러로 바꾼 다음
            .subscribe(onNext: { str in // onNext 되었을때 str 들어오면
                self.dateTimeLabel.text = str   // 여기 넣을거임
            })
         */
            .bind(to: dateTimeLabel.rx.text)    // == 42 ~ 45번째 줄
            .disposed(by: disposeBag)

        viewModel.viewDidLoad() // data fetch
    }
}

//
//  ViewController.swift
//  MVVM-Final
//
//  Created by 정은희 on 2022/08/19.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension ViewController {
    private func bind() {
        viewModel.onUpdate = { [weak self] in
            // call-back 받아 UI를 변경시킴
            DispatchQueue.main.async {
                self?.dateTimeLabel.text = self?.viewModel.dateTimeString
            }
        }
        viewModel.viewDidLoad() // data fetch
    }
}

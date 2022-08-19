//
//  Repository.swift
//  MVVM-Final
//
//  Created by 정은희 on 2022/08/19.
//

import Foundation

class Repository {
    func fetchNow(onCompleted: @escaping (UTCTimeModel) -> Void) {
        let url = "http://worldclockapi.com/api/json/utc/now"
        URLSession.shared.dataTask(with: URL(string: url)!) { data, _, _ in
            guard let data = data else { return }
            guard let model = try? JSONDecoder().decode(UTCTimeModel.self, from: data)
            else { return }
            onCompleted(model)
        }.resume()
    }
}

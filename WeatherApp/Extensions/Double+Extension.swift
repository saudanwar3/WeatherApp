//
//  Double+Extension.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 24/05/2022.
//

import UIKit

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
}

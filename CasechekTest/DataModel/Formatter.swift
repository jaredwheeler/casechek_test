//
//  Formatter.swift
//  CasechekTest
//
//  Created by Jared Wheeler on 11/2/18.
//  Copyright © 2018 Jared Wheeler. All rights reserved.
//

import Foundation

class Formatter {
    static func dateFrom(IS08601String: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        let date = dateFormatter.date(from: IS08601String)
        return date
    }
}

//
//  String+Extension.swift
//  SpacelixTests
//
//  Created by BARIS UYAR on 11.03.2022.
//

import Foundation

extension String {

    func loadJson() -> [String: Any] {
        do {
            if let bundle = Bundle(identifier: "com.buyar.SpacelixTests"),
               let filePath = bundle.path(forResource: self, ofType: "json") {
                let fileUrl = URL(fileURLWithPath: filePath)
                let data = try Data(contentsOf: fileUrl)
                let testVariable = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
                return testVariable
            }
        } catch {
            return [:]
        }
        return [:]
    }
}

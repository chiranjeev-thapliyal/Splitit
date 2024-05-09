//
//  Helpers.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 07/05/24.
//

import Foundation
import SwiftUI

func prettyPrint(data: Data){
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        let prettyData = try JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted)
        if let prettyString = String(data: prettyData, encoding: .utf8) {
            print("Pretty JSON: \(prettyString)")
        }
    } catch {
        print("Failed to convert JSON to pretty print format")
    }
}

func lastTenDigits(of number: String) -> String {
    let digits = number.filter("0123456789".contains)
    return String(digits.suffix(10))
}

func addPrecision(_ number: Double, precision: Int) -> String {
    return String(format: "%.\(precision)f", number)
}


func openAppSettings() {
    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsUrl) else {
        print("Unable to open app settings")
        return
    }

    UIApplication.shared.open(settingsUrl) { success in
        if success {
            print("Settings opened successfully")
        } else {
            print("Failed to open settings")
        }
    }
}

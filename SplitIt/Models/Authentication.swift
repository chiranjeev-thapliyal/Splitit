//
//  Authentication.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 03/05/24.
//

import Foundation
import SwiftUI

struct LoginCredentials: Codable, Hashable {
    let email: String
    let password: String
}

struct LoginResponse: Codable, Hashable {
    let token: String
    let email: String
    let name: String
}

//
//  Users.swift
//  SplitIt
//
//  Created by Chiranjeev Thapliyal on 07/05/24.
//

import Foundation

struct PublicUser: Codable, Hashable {
    let id: UUID
    let name: String
}

struct TemporaryUser: Codable, Hashable {
    let id: UUID
    let name: String
    let phoneNumber: String
}

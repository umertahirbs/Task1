//
//  RegisterRM.swift
//  Task1
//
//  Created by Umer Tahir on 02/03/2022.
//

import Foundation

struct AuthRM: Codable {
    let success: Bool?
    let data: User?
}

// MARK: - DataClass
struct User: Codable {
    let accessToken, refreshToken: String?
    let userID: Int?
    let email: String?
    let image: String?
    let firstName, lastName: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case userID = "user_id"
        case email, image
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

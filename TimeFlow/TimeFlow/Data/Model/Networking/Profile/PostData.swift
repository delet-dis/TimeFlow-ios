//
//  PostData.swift
//  TimeFlow
//
//  Created by Семён Алимпиев on 06.03.2023.
//

import Foundation

struct PostData: Codable, Identifiable {
    let id: String
    let postRole: String
    let postName: String
}

//
//  QueueIdElement.swift
//  OpggClone
//
//  Created by Sy Lee on 2023/02/19.
//

import Foundation

struct QueueIdElement: Codable {
    let queueId: Int
    let map: String
    let description, notes: String?

    enum CodingKeys: String, CodingKey {
        case queueId, map, description, notes
    }
}

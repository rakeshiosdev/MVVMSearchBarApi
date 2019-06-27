//
//  ResultModel.swift
//  Test
//
//  Created by RakeshPC on 25/06/19.
//  Copyright © 2019 RakeshPC. All rights reserved.
//

import UIKit

typealias ResultModel = [UserModel]

struct UserModel: Codable {
  let userID, id: Int
  let title, body: String
  
  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case id, title, body
  }
}

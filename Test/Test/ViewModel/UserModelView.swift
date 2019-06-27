//
//  UserModelView.swift
//  Test
//
//  Created by RakeshPC on 25/06/19.
//  Copyright © 2019 RakeshPC. All rights reserved.
//

import UIKit

class UserModelView: Codable {

    var title: String?
    var body: String?
    
    init(uesrs: UserModel) {
        self.title = uesrs.title
        self.body = uesrs.body
    }
}

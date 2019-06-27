//
//  ServiceManager.swift
//  Test
//
//  Created by RakeshPC on 25/06/19.
//  Copyright © 2019 RakeshPC. All rights reserved.
//

import UIKit

class ServiceManager: NSObject {

    static let shared = ServiceManager()
    
    func getUesrData(completion: @escaping([UserModel]?, Error?) -> ()){
        
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                completion(nil, err)
                print("loading data error \(err.localizedDescription)")
            }else{
                guard let data  = data else {return}
                
                do {
                    let result = try JSONDecoder().decode(ResultModel.self, from: data)
                   completion(result, nil)
    
                } catch let jsonError {
                    print("json error: \(jsonError.localizedDescription)")
                }
            }
        }.resume()
    }
}

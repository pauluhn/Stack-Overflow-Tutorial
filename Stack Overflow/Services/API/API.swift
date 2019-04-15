//
//  API.swift
//  Stack Overflow
//
//  Created by Peter Gustafson on 4/9/19.
//  Copyright © 2019 Peter Gustafson. All rights reserved.
//

import Foundation

class API {
    let baseURL: String
    let parameters: String
    
    init(baseURL: String, parameters: String) {
        self.baseURL = baseURL
        self.parameters = parameters
    }
    
    func get(completion: @escaping ([Question]) -> Void) {
        // construct url object
        let base = URL(string: baseURL)
        guard let url = URL(string: parameters, relativeTo: base) else {
            // log error
            print("url is bad. create bug fix in JIRA")
            return
        }
        
        // give that object to URLSession
//        let task = URLSession.shared.dataTask(with: url)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // we now get data back. what do we do?
            guard let unwrappedData = data else {
                // log error
                print("we need to return something... maybe?")
                return
            }
            let decoder = JSONDecoder()
            do {
                let wrapper = try decoder.decode(Wrapper.self, from: unwrappedData)
                completion(wrapper.questions)
                
            } catch {
                // log error
                print(error.localizedDescription)
                // do we do anything else?
            }
        }
        task.resume()
        
        
    }
}

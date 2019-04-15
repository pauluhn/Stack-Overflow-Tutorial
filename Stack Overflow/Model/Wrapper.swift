//
//  Wrapper.swift
//  Stack Overflow
//
//  Created by Peter Gustafson on 4/9/19.
//  Copyright © 2019 Peter Gustafson. All rights reserved.
//

import Foundation

struct Wrapper: Codable {
    var questions: [Question]
    
    enum CodingKeys: String, CodingKey {
        case questions = "items"
    }
}

// MARK: - normally, we would want to put protocols in separate files
protocol Whatever {
    func asdf()
}

// MARK: - extension of whatever protocol
extension Wrapper: Whatever {
    func asdf() {
        // lasdjflkasjdf
    }
    
    
}

//
//  RequestManager.swift
//  DiagnalProgrammingTest
//
//  Created by Chetan Girase on 15/05/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import UIKit

class RequestManager {
    class var sharedInstance: RequestManager {
        struct Singleton {
            static let instance = RequestManager()
        }
        return Singleton.instance
    }
    
    // MARK: - Load API Data from the Local JSON file
    func getAPIData(forResource: String, ofType: String, completion: @escaping(Data?, Error?) -> Void) {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: forResource, ofType: ofType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        } else {
            completion(nil, nil)
        }
    }
}

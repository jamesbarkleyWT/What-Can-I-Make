//
//  Utilities.swift
//  What Can I Make
//
//  Created by James Barkley on 7/6/21.
//

import Foundation

class Utilities {

    func isPasswordValid(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@",
                                       "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        
        return passwordTest.evaluate(with: password)
    }

}

//
//  UserValidator.swift
//  Goals For Good
//
//  Created by Ahmed Al-Zahrani on 2018-05-09.
//  Copyright © 2018 Ahmed Al-Zahrani. All rights reserved.
//

import Foundation

struct UserValidator {

    // isEmalAddressValid uses RegEx to return a bool ensuring we have a proper e-mail address
    func isEmailAddressValid(emailAddress: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"

        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddress as NSString
            let results = regex.matches(in: emailAddress, range: NSRange(location: 0, length: nsString.length))

            if results.count == 0 { return false}
        }
        catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return false
        }
        return true
    }

    // return Bool re: password validity
    // a Valid password is 8-15 chars, one lower case, one upper case, and one special char
    func isPasswordValid(password: String) -> Bool{
        let passwordRegEx = "^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,15}$"

        do {
            let regex = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = password as NSString
            let results = regex.matches(in: password, range: NSRange(location: 0, length: nsString.length))

            if results.count == 0 {
                print("Password didn't match regex expectations")
                print("Password must be 8-15 characters, with one lower, one upper, and one special char")
                return false}
        }

        catch let error as NSError {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
        return true
    }

}

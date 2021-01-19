//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by Jackson Chui on 1/18/21.
//
/*
enums of Associated values: Declare the type after each case
enums of Raw values: Have default values all of the same type
 */

import Foundation

enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}

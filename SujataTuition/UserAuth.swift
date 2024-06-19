//
//  UserAuth.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 10/03/24.
//

import Foundation
import Combine

class UserAuth: ObservableObject{
    @Published var isLoggedin: Bool = false
    @Published var email: String = ""
    func login(){
        self.isLoggedin = true
    }
    func emailcheck(){
        self.email = ""
    }
}

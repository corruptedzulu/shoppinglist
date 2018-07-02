//
//  Completable.swift
//  apiserver
//
//  Created by Spencer on 6/23/18.
//

import Foundation



protocol Completable {
    
    var isComplete : Bool { get }
    
    func complete() -> Bool;
    
}


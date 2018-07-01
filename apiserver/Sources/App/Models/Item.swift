//
//  Item.swift
//  apiserver
//
//  Created by Spencer on 6/23/18.
//

import Foundation


class Item : Completable {
    
    var isComplete: Bool;
    let createdTime: Date;
    var editedTime: Date;
    
    
    
    init(){
        
        isComplete = false;
        createdTime = Date();
        editedTime = Date();
        
    }
    
    init(completed : Bool, created: Date, edited: Date) {
        
        isComplete = completed;
        createdTime = created;
        editedTime = edited;
        
    }
    
    func complete() -> Bool {
        
        isComplete = true;
        
        return isComplete;
    }
    
}

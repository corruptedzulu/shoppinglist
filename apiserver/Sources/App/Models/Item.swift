//
//  Item.swift
//  apiserver
//
//  Created by Spencer on 6/23/18.
//

import Foundation
import Vapor
import FluentMySQL

final class Item : Completable, MySQLModel {
    
    var id: Int?;
    
    var title: String;
    var description: String;
    
    var isComplete: Bool;
    var createdTime: Int?;
    var editedTime: Int?;
    
    
    
    init(){
        
        title = "";
        description = "";
        isComplete = false;
        createdTime = 0;
        editedTime = 0;
        //createdTime = Date();
        //editedTime = Date();
        
    }
        
    init(id: Int? = nil, titleString: String, descriptionString: String, completed : Bool, created: Int? = 0, edited: Int? = 0){
        
        title = titleString;
        description = descriptionString;
        isComplete = completed;
        createdTime = created;
        editedTime = edited;
        
    }
    
    func complete() -> Bool {
        
        isComplete = true;
        
        return isComplete;
    }
    
    /*func willUpdate(on conn: MySQLConnection) throws -> EventLoopFuture<Item> {
        print("will update");
        
        return Future.map(on: conn) { self }
    }
    
    func didUpdate(on conn: MySQLConnection) throws -> EventLoopFuture<Item> {
        print("did update");
        
        return Future.map(on: conn) { self }
    }
    
    func willCreate(on conn: MySQLConnection) throws -> EventLoopFuture<Item> {
        print("will create");
        
        return Future.map(on: conn) { self }
    }*/
    
}

/// Allows `Todo` to be used as a dynamic migration.
extension Item: Migration { }

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Item: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Item: Parameter { }


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
    var ownerId: Int;
    
    var title: String;
    var description: String;
    
    var isComplete: Bool;
    var createdTime: Int?;
    var editedTime: Int?;
    
    
    /// The parent relation is one side of a one-to-many database relation.
    ///
    /// The parent relation will return the parent model that the supplied child references.
    ///
    /// The opposite side of this relation is called `Children`.
    ///
    ///     final class Pet: Model {
    ///         var userID: UUID
    ///         ...
    ///         var user: Parent<Pet, User> {
    ///             return parent(\.userID)
    ///         }
    ///     }
    ///
    ///     final class User: Model {
    ///         var id: UUID?
    ///         ...
    ///     }
    
    var owner: Parent<Item, User> {
        return parent(\.ownerId);
    }
    
    init(){
        ownerId = 0;
        title = "";
        description = "";
        isComplete = false;
        createdTime = 0;
        editedTime = 0;
        //createdTime = Date();
        //editedTime = Date();
        
    }
        
    init(id: Int? = nil, titleString: String, descriptionString: String, completed : Bool, created: Int? = 0, edited: Int? = 0){
        
        ownerId = 0;
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
extension Item: Migration {
    
    static func prepare(on connection: MySQLConnection) -> Future<Void> {
        return MySQLDatabase.create(self, on: connection) { builder in
            try builder.field(for: \.id);
            try builder.field(for: \.ownerId);
            try builder.field(for: \.title);
            try builder.field(for: \.description);
            try builder.field(for: \.isComplete);
            try builder.field(for: \.createdTime);
            try builder.field(for: \.editedTime);
            
        }
    }
    
    static func revert(on connection: MySQLConnection) -> Future<Void> {
        return MySQLDatabase.delete(self, on: connection);
    }
}

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension Item: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension Item: Parameter { }


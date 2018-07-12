//    apiserver
//
//    User.swift
//
//    ___ORGANIZATIONNAME___
//
//    10:11 PM 7/5/18
//
//    Spencer
//


import Foundation
import Vapor
import FluentMySQL

final class User : MySQLModel {
    
    var id: Int?;
    
    //account info
    var username: String;
    //NOTE: PLACEHOLDER. DO NOT ACTUALLY USE FOR PWs
    var password: String;
    var createdTime: Int?;
    var editedTime: Int?;
    var isVerified: Bool;
    
    //user details
    var contactEmail: String;
    var firstName: String;
    var lastName: String;
    
    /// The children relation is one side of a one-to-many database relation.
    ///
    /// The children relation will return all the
    /// models that contain a reference to the parent's identifier.
    ///
    /// The opposite side of this relation is called `Parent`.
    ///
    ///     final class Pet: Model {
    ///         var userID: UUID
    ///         ...
    ///     }
    ///
    ///     final class User: Model {
    ///         var id: UUID?
    ///         ...
    ///         var pets: Children<User, Pet> {
    ///             return children(\.userID)
    ///         }
    ///     }
    
    var items: Children<User, Item>{
        return children(\.id)
    }
    
    
    init(){
        
        username = "";
        password = "";
        createdTime = 0;
        editedTime = 0;
        isVerified = false;
        contactEmail = "";
        firstName = "";
        lastName = "";
        
    }
    
    init(id: Int? = nil, usernameString: String, passwordString: String, verified : Bool, created: Int? = 0, edited: Int? = 0, contactemailString: String, firstnameString: String, lastnameString: String){
        
        username = usernameString;
        password = passwordString;
        createdTime = created;
        editedTime = edited;
        isVerified = verified;
        contactEmail = contactemailString;
        firstName = firstnameString;
        lastName = lastnameString;
    }
    
}

/// Allows `Todo` to be used as a dynamic migration.
extension User: Migration {
    
    static func prepare(on connection: MySQLConnection) -> Future<Void> {
        return MySQLDatabase.create(self, on: connection) { builder in
            try builder.field(for: \.id);
            try builder.field(for: \.username);
            try builder.field(for: \.password);
            try builder.field(for: \.createdTime);
            try builder.field(for: \.editedTime);
            try builder.field(for: \.isVerified);
            try builder.field(for: \.contactEmail);
            try builder.field(for: \.firstName);
            try builder.field(for: \.lastName);

        }
    }
    
    static func revert(on connection: MySQLConnection) -> Future<Void> {
        return MySQLDatabase.delete(self, on: connection);
    }
    
}

/// Allows `Todo` to be encoded to and decoded from HTTP messages.
extension User: Content { }

/// Allows `Todo` to be used as a dynamic parameter in route definitions.
extension User: Parameter { }


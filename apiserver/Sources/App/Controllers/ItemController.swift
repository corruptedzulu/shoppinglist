//
//  ItemController.swift
//  apiserver
//
//  Created by Spencer on 6/23/18.
//

import Foundation
import Vapor

/// Controls basic CRUD operations on `Todo`s.
final class ItemController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Item]> {
        return Item.query(on: req).all()
    }
    
    /// Saves a decoded `Todo` to the database.
    func create(_ req: Request) throws -> Future<Item> {
        
        
        return try req.content.decode(json: Item.self, using: .custom(dates: JSONDecoder.DateDecodingStrategy.millisecondsSince1970) ).flatMap { item in
            return item.save(on: req);
        }
    }
    
    /// Deletes a parameterized `Todo`.
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Item.self).flatMap { item in
            return item.delete(on: req)
        }.transform(to: .ok)
    }
    
    
    func update(_ req: Request) throws -> Future<Item> {
        
        
        return try req.parameters.next(Item.self).flatMap { item in
            return try req.content.decode(json: Item.self, using: .custom(dates: JSONDecoder.DateDecodingStrategy.millisecondsSince1970) ).flatMap { newItem in
                
                item.createdTime = newItem.createdTime;
                item.description = newItem.description;
                item.editedTime = newItem.editedTime;
                item.isComplete = newItem.isComplete;
                item.title = newItem.title;
                return item.save(on: req)
            }
        }
        
    }
    
    
}

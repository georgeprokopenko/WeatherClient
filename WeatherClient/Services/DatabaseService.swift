//
//  DatabaseService.swift
//  WeatherClient
//
//  Created by George Prokopenko on 16/02/2020.
//  Copyright © 2020 George Prokopenko. All rights reserved.
//

import Foundation
import RealmSwift

protocol DatabaseServicing {
    func saveObject<T>(_ object: T) where T: Object
    func removeObject<T>(_ object: T) where T: Object
    func savedObjects<T>(type: T.Type) -> [T]? where T: Object
    func modify(_ block: () -> Void)
}

class DatabaseService: DatabaseServicing {
    func saveObject<T>(_ object: T) where T: Object {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.add(object, update: .modified)
            try realm.commitWrite()
        }
        catch (let error) {
            print(error)
        }
    }
    
    func removeObject<T>(_ object: T) where T: Object {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(object)
            try realm.commitWrite()
        }
        catch (let error) {
            print(error)
        }
    }
    
    func savedObjects<T>(type: T.Type) -> [T]? where T: Object {
        do {
            let realm = try Realm()
            let obj = realm.objects(T.self)
            return obj.map { $0 }
        }
        catch (let error) {
            print(error)
            return []
        }
    }

    func modify(_ block: () -> Void) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            block()
            try realm.commitWrite()
        }
        catch (let error) {
            print(error)
        }
    }
}

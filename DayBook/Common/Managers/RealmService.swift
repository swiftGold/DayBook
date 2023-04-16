//
//  RealmManager.swift
//  DayBook
//
//  Created by Сергей Золотухин on 10.04.2023.
//

import RealmSwift

final class RealmService {
    var realm: Realm {
        do {
            let realm = try Realm(configuration: .defaultConfiguration)
            return realm
        } catch  {
            fatalError("RealmServiceError in instance initialize Realm() - \(error.localizedDescription)")
        }
    }
}

extension RealmService {
    func create<T: Object>(_ object: T, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try realm.write {
                realm.add(object)
                completion(.success(Void()))
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    func read<T: Object>(_ object: T.Type) -> Results<T> {
        return realm.objects(T.self)
    }

    func update <T: Object>(_ object: T, with dictionary: [String: Any?], completion: @escaping (Result<Void, Error>) -> Void) {
        
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                    completion(.success(Void()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
        
    func delete<T: Object>(_ object: T, completion: @escaping (Result<Void, Error>) -> Void) {
        
        do {
            try realm.write {
                realm.delete(object)
                completion(.success(Void()))
            }
        } catch {
            completion(.failure(error))
        }
    }
}


//
//  DataManager.swift
//  KliraTest
//
//  Created by Antonio Casamassa on 2019-06-19.
//  Copyright © 2019 Antonio Casamassa. All rights reserved.
//

import Foundation

class DataManager {
    
     static let singleton = DataManager()
     static var words = [Word]()
     static var tenthWords = [Word]()
     static var totalWords = "Total words"
    
     static func decodeJSON<T>(modelType: T.Type, data: Data, event: String) where T : Decodable {
        do {
            let decoded = try JSONDecoder().decode(modelType, from: data) as? Words
            
            switch event {
            case EVENT_EVERY_10:
                decoded?.items.forEach({ (item) in
                    DataManager.tenthWords.append(item)
                })
                break
            case EVENT_ALL:
                decoded?.items.forEach({ (item) in
                    DataManager.words.append(item)
                })
                let total = decoded!.total
                let text = String.init(format: "There are %@ unique words", total)
                totalWords = text
                break
            default:
                break
            }
        } catch {
            print("ERROR!!!",error, event)
        }
        Events.send(key: event, info: nil)
    }
}

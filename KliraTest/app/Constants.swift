//
//  Constants.swift
//  KliraTest
//
//  Created by Antonio Casamassa on 2019-06-19.
//  Copyright © 2019 Antonio Casamassa. All rights reserved.
//

import Foundation

let API_SERVICE = "http://klira.antoniocasamassa.com/api/"
let ENDPOINT_CRAWL = "request.php"
let ENDPOINT_AGGREGATOR = "words_aggregator.php"
let EVENT_URL_CRAWLED = "URL_CRAWLED"
let EVENT_SERVER_ERROR = "SERVER_ERROR"
let EVENT_EVERY_10 = "EVENT_EVERY_10"
let EVENT_ALL = "EVENT_ALL"
let AGGREGATE_EVERY_10 = "/?type=every10"
let AGGREGATE_EVERY_ALL = "/?type=all"

enum JSONError: String, Error {
    case NoData = "ERROR: no data"
    case ConversionFailed = "ERROR: conversion from JSON failed"
}

struct Words: Decodable {
    
    let items: [Word]
    let total: String
    
    enum CodingKeys : String, CodingKey {
        case items = "results"
        case total = "total"
    }
}

struct Word: Decodable {
    let word: String
    var num: String
}

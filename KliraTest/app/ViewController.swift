//
//  ViewController.swift
//  KliraTest
//
//  Created by Antonio Casamassa on 2019-06-19.
//  Copyright © 2019 Antonio Casamassa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let httpClient = HttpClient()
    var cell: UITableViewCell?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var status: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        createEvents()
    }
    
    @IBAction func crawlUrl(_ sender: Any) {
        if DataManager.words.count == 0 {
            httpClient.makeRequest(url: API_SERVICE + ENDPOINT_CRAWL, event: EVENT_URL_CRAWLED, completion: {data in
                Events.send(key: EVENT_URL_CRAWLED, info: nil)
            })
        } else {
            status.text = "URL has already been crawled"
        }
    }
   
    func aggregate(type: String, event: String) {
        httpClient.makeRequest(url: API_SERVICE + ENDPOINT_AGGREGATOR + type, event: event, completion: {data in
            DataManager.decodeJSON(modelType: Words.self, data: data, event: event)
        })
    }
    
    @objc fileprivate func urlCrawled() {
        DispatchQueue.main.async {
            self.status.text = "URL CRAWLED SUCCESSFULLY"
        }
        aggregate(type: AGGREGATE_EVERY_10,event: EVENT_EVERY_10)
        aggregate(type: AGGREGATE_EVERY_ALL,event: EVENT_ALL)
    }
    
    @objc fileprivate func serverError() {
        status.text = "CRAWL FAILED :("
    }
    
    @objc fileprivate func updateTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    fileprivate func createEvents() {
        Events.on(EVENT_URL_CRAWLED, self, #selector(urlCrawled))
        Events.on(EVENT_EVERY_10, self, #selector(updateTable))
        Events.on(EVENT_ALL, self, #selector(updateTable))
        Events.on(EVENT_SERVER_ERROR, self, #selector(serverError))
    }
}


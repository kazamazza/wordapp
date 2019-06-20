//
//  ViewController+Table.swift
//  KliraTest
//
//  Created by Antonio Casamassa on 2019-06-19.
//  Copyright © 2019 Antonio Casamassa. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return DataManager.tenthWords.count
        case 2:
            return DataManager.words.count
        default:
            return 1
        }
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
        let section = indexPath.section
        
        switch section {
        case 0:
            if DataManager.tenthWords.count != 0 {
                cell.textLabel?.text = DataManager.tenthWords[0].word
            }
            break
        case 1:
            if DataManager.tenthWords.count != 0 {
                cell.textLabel?.text = DataManager.tenthWords[indexPath.row].word
            }
            break
        case 2:
            if DataManager.words.count != 0 {
                let word = DataManager.words[indexPath.row].word
                let num = DataManager.words[indexPath.row].num
                var text: String
                if Int(num)! > 1 {
                   text = String.init(format: "The word %@ appears %@ times" , word, num)
                } else {
                   text = String.init(format: "The word %@ appears %@ time" , word, num)
                }
                cell.textLabel?.text = text
            }
            break
        default:
            break
        }

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "10th word"
        case 1:
            return "Every 10th word"
        case 2:
            return DataManager.totalWords
        default:
            return "blank"
        }
    }
}

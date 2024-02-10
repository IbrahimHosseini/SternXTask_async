//
//  Dictionary+sort.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/9/24.
//

import Foundation

extension Dictionary {
    func keysSortedByValue(_ isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return Array(self)
            .sorted() {
                let (_, lv) = $0
                let (_, rv) = $1
                return isOrderedBefore(lv, rv)
            }
            .map {
                let (k, _) = $0
                return k
            }
    }
}

//
//  Dictionary+sort.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/9/24.
//

import Foundation

/// Extension to sort dictionary keys based on their associated values.
extension Dictionary {

    /// Sorts the keys of the dictionary based on the provided comparison function.
    ///
    /// - Parameter isOrderedBefore: A closure that takes two values and returns a boolean indicating whether the first value should come before the second value in the sorted array.
    ///
    /// - Returns: An array of keys sorted based on the provided comparison function.
    func keysSortedByValue(_ isOrderedBefore: @escaping (Value, Value) -> Bool) -> [Key] {
        return Array(self)
            .sorted(by: {
                let (_, lv) = $0
                let (_, rv) = $1
                return isOrderedBefore(lv, rv)
            })
            .map {
                let (k, _) = $0
                return k
            }
    }
}

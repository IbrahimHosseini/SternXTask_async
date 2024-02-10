//
//  Sequesnce+unique.swift
//  SternXTask
//
//  Created by Ibrahim Hosseini on 2/9/24.
//

import Foundation

extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}

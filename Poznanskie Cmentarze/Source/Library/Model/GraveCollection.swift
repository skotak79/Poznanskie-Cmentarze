//
//  GraveCollection.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 30/08/2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import Foundation
class GraveCollection {

    private let concurrentGraveQueue = DispatchQueue(label: "graveQueue", attributes: .concurrent)
    private var tempGraves: [Grave] = []
    var graves: [Grave] {
        var gravesCopy: [Grave]!
        concurrentGraveQueue.sync {
            gravesCopy = self.tempGraves
        }
        return gravesCopy
    }

    func add(graves: [Grave]) {
        concurrentGraveQueue.async(flags: .barrier) { [weak self] in
            guard let self = self else {
                return
            }
            self.tempGraves += graves
        }
    }

    func removeAll() {
        self.tempGraves.removeAll()
    }
}

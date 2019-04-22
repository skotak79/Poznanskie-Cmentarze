//
//  Adapter.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 08.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

/// A generic adapter to act as a convenient Datasource and Delegate for UITableView
final class Adapter<T, Cell: UITableViewCell>: NSObject, UITableViewDataSource, UITableViewDelegate {
    var items: [T] = []
    var configure: ((T, Cell) -> Void)?
    var select: ((T) -> Void)?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
        let item = items[indexPath.row]
        configure?(item, cell)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        select?(item)
    }
}

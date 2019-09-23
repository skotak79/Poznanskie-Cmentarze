//
//  GraveCell.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 27.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit
final class GraveCell: UITableViewCell {

    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Setup

    private func setup() {
        self.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
    }
}

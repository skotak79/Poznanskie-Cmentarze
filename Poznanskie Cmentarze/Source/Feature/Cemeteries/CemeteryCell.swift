//
//  CemeteryCell.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 09.01.2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import UIKit

final class CemeteryCell: UITableViewCell {

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
        self.accessoryType = .disclosureIndicator
        backgroundColor = UIColor.white
    }
}

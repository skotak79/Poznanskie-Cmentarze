//
//  AboutView.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 22.11.2018.
//  Copyright © 2018 Wojtek Skotak. All rights reserved.
//

import UIKit

final class AboutView: UIView {
    private let scrollableView = ScrollableView()
    
    private let contentView = UIView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.darkText
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.font = UIFont.preferredCustomFont(forTextStyle: .body)
        
        return label
    }()

    private let separator: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        
        return view
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.darkText
        label.backgroundColor = UIColor.clear
        label.textAlignment = .left
        label.font = UIFont.preferredCustomFont(forTextStyle: .body)

        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

    // MARK: - Setup
    
    private func setup() {
        titleLabel.text = Constants.aboutScreenTitle
        contentLabel.text = Constants.aboutScreenDescription
        addSubview(scrollableView)
        NSLayoutConstraint.pinToSafeAreas(view: scrollableView, toEdgesOf: self)
        scrollableView.setup(pairs: [
            ScrollableView.Pair(view: titleLabel, inset: UIEdgeInsets(top: 8, left: 15, bottom: 0, right: 15)),
            ScrollableView.Pair(view: separator, inset: UIEdgeInsets(top: 16, left: 15, bottom: 0, right: 15)),
            ScrollableView.Pair(view: contentLabel, inset: UIEdgeInsets(top: 16, left: 15, bottom: 0, right: 15))
            ])
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: 0.5)
            ])
    }
}

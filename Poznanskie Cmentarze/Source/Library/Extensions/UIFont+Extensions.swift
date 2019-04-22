//
//  UIFont+Extensions.swift
//  Poznanskie Cmentarze
//
//  Created by Wojtek Skotak on 03.01.2019.
//  Copyright © 2019 Wojtek Skotak. All rights reserved.
//

import UIKit
extension UIFont {
    class func preferredCustomFont(forTextStyle textStyle: UIFont.TextStyle) -> UIFont {
        let fontsize: CGFloat = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle).pointSize
        var customFont = UIFont.preferredFont(forTextStyle: textStyle)

        switch textStyle {
        case UIFont.TextStyle.headline, UIFont.TextStyle.subheadline:
            guard let font = R.font.playfairDisplayRegular(size: fontsize) else {
                fatalError(getErrorMessage(forFontName: "PlayfairDisplay-Regular"))
            }
            customFont = UIFontMetrics.default.scaledFont(for: font)
        case UIFont.TextStyle.caption1, UIFont.TextStyle.body:
            guard let font = R.font.openSans(size: fontsize) else {
                fatalError(getErrorMessage(forFontName: "OpenSans"))
            }
            customFont = UIFontMetrics.default.scaledFont(for: font)
        case UIFont.TextStyle.title1:
            guard let font = R.font.openSansSemibold(size: fontsize) else {
                fatalError(getErrorMessage(forFontName: "OpenSans-Semibold"))
            }
            customFont = UIFontMetrics.default.scaledFont(for: font)
        default:
            break
        }
        return customFont
    }
    
    class func getErrorMessage(forFontName name: String) -> String {
        return """
        Failed to load "\(name)" font. Make sure the font file is included in the project
        """
    }
}

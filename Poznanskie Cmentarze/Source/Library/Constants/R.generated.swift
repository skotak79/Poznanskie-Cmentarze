//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try font.validate()
    try intern.validate()
  }
  
  /// This `R.file` struct is generated, and contains static references to 3 files.
  struct file {
    /// Resource file `Apache License.txt`.
    static let apacheLicenseTxt = Rswift.FileResource(bundle: R.hostingBundle, name: "Apache License", pathExtension: "txt")
    /// Resource file `Default-568h@2x.png`.
    static let default568h2xPng = Rswift.FileResource(bundle: R.hostingBundle, name: "Default-568h@2x", pathExtension: "png")
    /// Resource file `OFL.txt`.
    static let oflTxt = Rswift.FileResource(bundle: R.hostingBundle, name: "OFL", pathExtension: "txt")
    
    /// `bundle.url(forResource: "Apache License", withExtension: "txt")`
    static func apacheLicenseTxt(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.apacheLicenseTxt
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "Default-568h@2x", withExtension: "png")`
    static func default568h2xPng(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.default568h2xPng
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "OFL", withExtension: "txt")`
    static func oflTxt(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.oflTxt
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 4 fonts.
  struct font: Rswift.Validatable {
    /// Font `OpenSans-Semibold`.
    static let openSansSemibold = Rswift.FontResource(fontName: "OpenSans-Semibold")
    /// Font `OpenSans`.
    static let openSans = Rswift.FontResource(fontName: "OpenSans")
    /// Font `PlayfairDisplay-Bold`.
    static let playfairDisplayBold = Rswift.FontResource(fontName: "PlayfairDisplay-Bold")
    /// Font `PlayfairDisplay-Regular`.
    static let playfairDisplayRegular = Rswift.FontResource(fontName: "PlayfairDisplay-Regular")
    
    /// `UIFont(name: "OpenSans", size: ...)`
    static func openSans(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: openSans, size: size)
    }
    
    /// `UIFont(name: "OpenSans-Semibold", size: ...)`
    static func openSansSemibold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: openSansSemibold, size: size)
    }
    
    /// `UIFont(name: "PlayfairDisplay-Bold", size: ...)`
    static func playfairDisplayBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: playfairDisplayBold, size: size)
    }
    
    /// `UIFont(name: "PlayfairDisplay-Regular", size: ...)`
    static func playfairDisplayRegular(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: playfairDisplayRegular, size: size)
    }
    
    static func validate() throws {
      if R.font.openSans(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'OpenSans' could not be loaded, is 'OpenSans-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.openSansSemibold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'OpenSans-Semibold' could not be loaded, is 'OpenSans-Semibold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.playfairDisplayBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'PlayfairDisplay-Bold' could not be loaded, is 'PlayfairDisplay-Bold.ttf' added to the UIAppFonts array in this targets Info.plist?") }
      if R.font.playfairDisplayRegular(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'PlayfairDisplay-Regular' could not be loaded, is 'PlayfairDisplay-Regular.ttf' added to the UIAppFonts array in this targets Info.plist?") }
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 6 images.
  struct image {
    /// Image `Default-568h`.
    static let default568h = Rswift.ImageResource(bundle: R.hostingBundle, name: "Default-568h")
    /// Image `info`.
    static let info = Rswift.ImageResource(bundle: R.hostingBundle, name: "info")
    /// Image `launchImage`.
    static let launchImage = Rswift.ImageResource(bundle: R.hostingBundle, name: "launchImage")
    /// Image `list`.
    static let list = Rswift.ImageResource(bundle: R.hostingBundle, name: "list")
    /// Image `notFound`.
    static let notFound = Rswift.ImageResource(bundle: R.hostingBundle, name: "notFound")
    /// Image `search`.
    static let search = Rswift.ImageResource(bundle: R.hostingBundle, name: "search")
    
    /// `UIImage(named: "Default-568h", bundle: ..., traitCollection: ...)`
    static func default568h(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.default568h, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "info", bundle: ..., traitCollection: ...)`
    static func info(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.info, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "launchImage", bundle: ..., traitCollection: ...)`
    static func launchImage(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.launchImage, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "list", bundle: ..., traitCollection: ...)`
    static func list(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.list, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "notFound", bundle: ..., traitCollection: ...)`
    static func notFound(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.notFound, compatibleWith: traitCollection)
    }
    
    /// `UIImage(named: "search", bundle: ..., traitCollection: ...)`
    static func search(compatibleWith traitCollection: UIKit.UITraitCollection? = nil) -> UIKit.UIImage? {
      return UIKit.UIImage(resource: R.image.search, compatibleWith: traitCollection)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 2 storyboards.
  struct storyboard {
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try launchScreen.validate()
      try main.validate()
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "launchImage", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'launchImage' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UITabBarController
      
      let bundle = R.hostingBundle
      let name = "Main"
      
      static func validate() throws {
        if UIKit.UIImage(named: "info", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'info' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "list", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'list' is used in storyboard 'Main', but couldn't be loaded.") }
        if UIKit.UIImage(named: "search", in: R.hostingBundle, compatibleWith: nil) == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'search' is used in storyboard 'Main', but couldn't be loaded.") }
        if #available(iOS 11.0, *) {
        }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}

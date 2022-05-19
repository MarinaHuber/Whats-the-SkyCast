//
//  UILabel+Localize.swift
//  WeatherOnTheMap
//
//  Created by Marina Huber on 19.05.2022..
//  Copyright © 2022 Marina Huber. All rights reserved.
//
import UIKit


    // MARK: - UILabel localize Key extention for language in story board
@IBDesignable public extension UILabel {
    @IBInspectable var localizedText: String? {
        get {
            return text
        }
        set {
            text = NSLocalizedString(newValue ?? "", comment: "")
        }
    }
}

    // MARK: - UIButton localize Key extention for language in story board
@IBDesignable public extension UIButton {
    @IBInspectable var localized: String? {
        get {
            return ""
        }
        set {
            self.setTitle(newValue?.localized, for: .normal)
        }
    }
}

    // MARK: - UITextField localize Key extention for language in story board
@IBDesignable public extension UITextField {
    @IBInspectable var localizedPlaceholder: String? {
        get {
            return placeholder
        }
        set {
            text = NSLocalizedString(newValue ?? "", comment: "")
        }
    }
}

    // MARK: - UINavigationItem localize Key extention for language in story board
@IBDesignable public extension UINavigationItem {
    @IBInspectable var localizedText: String? {
        get {
            return title
        }
        set {
            title = NSLocalizedString(newValue ?? "", comment: "")
        }
    }
}



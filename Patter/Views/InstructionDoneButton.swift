//
//  InstructionDoneButton.swift
//  Patter
//
//  Created by Maksim Ivanov on 03/05/2019.
//  Copyright © 2019 Maksim Ivanov. All rights reserved.
//

import UIKit

// Simple button just for storyboard attributes
@IBDesignable
final class InstructionDoneButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }

}

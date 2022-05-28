//
//  UIColor.swift
//  Navigation
//
//  Created by Сергей Завьялов on 24.05.2022.
//

import UIKit

let colorSet = UIColor(hex: 0x4885CC)

// MARK: - перевод цвета из HEX в RGB для UIColor
extension UIColor {
    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
}

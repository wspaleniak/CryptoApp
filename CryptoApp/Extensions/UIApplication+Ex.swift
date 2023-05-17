//
//  UIApplication+Ex.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 17/05/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

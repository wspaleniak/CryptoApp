//
//  String+Ex.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 30/10/2023.
//

import Foundation

extension String {
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(
            of: "<[^>]+>",
            with: "",
            options: .regularExpression
        )
    }
}

//
//  XMarkButton.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 10/06/2023.
//

import SwiftUI

struct XMarkButton: View {
    
    let dismiss: DismissAction?
    
    var body: some View {
        Button(action: {
            dismiss?()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
        })
    }
}

struct XMarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XMarkButton(dismiss: nil)
    }
}

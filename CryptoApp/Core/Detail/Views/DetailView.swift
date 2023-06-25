//
//  DetailView.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 25/06/2023.
//

import SwiftUI

/// Widok pomocniczy, który tworzy głowny widok DetailView gdy przekazany coin jest != nil.
struct DetailLoadingView: View {
    
    @Binding var coin: Coin?
    
    var body: some View {
        ZStack {
            if let coin = coin {
                DetailView(coin: coin)
            }
        }
    }
}

/// Głowny widok pokazujący detale wybranego coina.
struct DetailView: View {
    
    let coin: Coin
    
    init(coin: Coin) {
        self.coin = coin
    }
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(coin: dev.bitcoin)
    }
}

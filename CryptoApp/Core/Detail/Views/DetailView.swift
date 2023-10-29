//
//  DetailView.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 25/06/2023.
//

import SwiftUI

/// Głowny widok pokazujący detale wybranego coina.
struct DetailView: View {
    
    @Environment(\.isPresented) private var isPresented
    @ObservedObject var vm: DetailViewModel
    @Binding var coin: Coin?
    
    init(vm: DetailViewModel, coin: Binding<Coin?>) {
        self.vm =  vm
        self._coin = coin
    }
    
    var body: some View {
        VStack {
            Text(coin?.name ?? "name")
            Text(vm.coinDetail?.description?.en ?? "description")
        }
        .onChange(of: isPresented) { isPresented in
            if !isPresented { coin = nil }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(vm: dev.detailVM, coin: .constant(dev.bitcoin))
    }
}

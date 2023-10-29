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
    
    private let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    private let spacing: CGFloat = 30
    
    init(vm: DetailViewModel) {
        self.vm =  vm
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("xyz")
                    .frame(height: 150)
                
                overviewTitle
                Divider()
                overviewGrid
                
                additionalTitle
                Divider()
                additionalGrid
            }
            .padding()
        }
        .navigationTitle(vm.coin.name)
    }
}

extension DetailView {
    
    private var overviewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []
        ) {
            ForEach(vm.overviewStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
    
    private var additionalTitle: some View {
        Text("Additional Details")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var additionalGrid: some View {
        LazyVGrid(
            columns: columns,
            alignment: .leading,
            spacing: spacing,
            pinnedViews: []
        ) {
            ForEach(vm.additionalStatistics) { stat in
                StatisticView(stat: stat)
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DetailView(
                vm: DetailViewModel(
                    coin: dev.ethereum,
                    coinDetailDataService: MockCoinDetailDataService()
                )
            )
        }
    }
}

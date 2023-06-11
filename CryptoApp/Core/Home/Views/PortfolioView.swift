//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Wojciech Spaleniak on 10/06/2023.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var vm: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var showCheckmark: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0.0) {
                    SearchBarView(searchText: $vm.searchText)
                    
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
                
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    XMarkButton(dismiss: dismiss)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    trailingNavigationBarButton
                }
            }
        }
    }
}

// MARK: - Extension
extension PortfolioView {
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10.0) {
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75.0)
                        .padding(6.0)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 15.0)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.accent : Color.clear, lineWidth: 1.0)
                        )
                }
            }
            .frame(height: 120.0)
            .padding(.horizontal)
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20.0) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Example 1.5", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .transaction { $0.animation = nil }
        .padding()
        .font(.headline)
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText),
           let selectedCoin {
            return quantity * selectedCoin.currentPrice
        }
        return 0.0
    }
    
    private var trailingNavigationBarButton: some View {
        HStack(spacing: 8.0) {
            Image(systemName: "checkmark")
                .foregroundColor(Color.theme.green)
                .opacity(showCheckmark ? 1.0 : 0.0)
            Button {
                saveButtonTapped()
            } label: {
                Text("Save")
                    .foregroundColor(Color.theme.accent)
                    .padding(.horizontal, 20.0)
                    .padding(.vertical, 6.0)
            }
            .buttonStyle(.plain)
            .background(
                Capsule()
                    .stroke(Color.theme.accent, lineWidth: 2.0)
            )
            .opacity(
                selectedCoin != nil &&
                selectedCoin?.currentHoldings != Double(quantityText) &&
                getCurrentValue() > 0 ? 1.0 : 0.0
            )
        }
        .font(.headline)
    }
    
    private func saveButtonTapped() {
        guard let coin = selectedCoin else { return }
        // TODO: save to porfolio
        withAnimation(.easeIn) {
            showCheckmark = true
        }
        UIApplication.shared.endEditing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(.easeOut) {
                removeSelectedCoin()
                showCheckmark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        vm.searchText = ""
        quantityText = ""
        selectedCoin = nil
    }
}

// MARK: - Preview
struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

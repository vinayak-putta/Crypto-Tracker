//
//  ContentView.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 12/01/24.
//

import SwiftUI

struct ContentListView: View {
    @StateObject var viewModel = CoinViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.coinModels) { coin in
                    NavigationLink {
                        CoinDetailView(coin: coin)
                    } label: {
                        CoinListCellView(coin: coin)
                    }.onAppear {
                        if coin == viewModel.coinModels.last {
                            Task { await viewModel.fetchCoinMarketListV2() }
                        }
                    }
                }
            }
            .navigationTitle("Cyrpto Currency")
        }
    }
}

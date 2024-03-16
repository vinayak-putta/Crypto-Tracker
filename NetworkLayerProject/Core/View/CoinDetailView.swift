//
//  CoinDetailView.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 14/01/24.
//

import SwiftUI

struct CoinDetailView: View {
    let coin: CoinModel
    @StateObject var coinDetailViewModel: CoinDetailViewModel
    
    init(coin: CoinModel) {
        self.coin = coin
        self._coinDetailViewModel = StateObject(wrappedValue: CoinDetailViewModel(coinID: coin.id))
    }
    
    var body: some View {
        VStack() {
            if let coinModel = coinDetailViewModel.coinModel {
                CoinDetailContentView(coinModel: coinModel)
            }
            else if let errorMessage = coinDetailViewModel.errorMessage {
                Text(errorMessage)
            }
            else {
                LoadingView()
            }
        }
        .task {
            await coinDetailViewModel.fetchCoinDetail()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Details")
        .padding()
    }
}

struct CoinDetailContentView: View {
    let imageSize: CGFloat = 300
    let coinModel: CoinDetailModel
    
    init(coinModel: CoinDetailModel) {
        self.coinModel = coinModel
    }
    var body: some View {
        ScrollView {
            VStack {
                if  let imageURL = URL(string: coinModel.image.large) {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .success(let image):
                            image.resizable()
                                .scaledToFit()
                                .frame(height: imageSize)
                                .clipped()
                        case .failure(let error):
                            Text(error.localizedDescription)
                                .foregroundColor(.gray)
                                .frame(width: imageSize, height: imageSize)
                        case .empty:
                            ProgressView()
                                .frame(width: imageSize, height: imageSize)
                        @unknown default:
                            ProgressView()
                                .frame(width: imageSize, height: imageSize)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text(coinModel.name)
                            Text(": $\(coinModel.marketData.currentPrice.usd)")
                        }
                        .font(.headline)
                        Text("SYMBOL: \(coinModel.symbol)")
                            .font(.footnote)
                        Text(coinModel.description.text)
                        
                        HStack {
                            Text("Market cap rating:")
                            Spacer()
                            ForEach(1..<6) { id in
                                Image(systemName: "star.fill")
                                    .foregroundColor(coinModel.markCapRank < id ? Color.gray : Color.accentColor)
                            }
                        }
                        Spacer()
                    }.padding()
                }
            }
        }
    }

}

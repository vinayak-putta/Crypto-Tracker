//
//  CoinListCellView.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 16/01/24.
//

import SwiftUI

struct CoinListCellView: View {
    let coin: CoinModel
    let imageSize: CGFloat = 50
    var body: some View {
        HStack(spacing: 20) {
            if let imageURL = URL(string: coin.image) {
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
            } else {
                Color.gray.frame(width: imageSize, height: imageSize)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(coin.name)
                    .font(.headline)
                Text("\(coin.symbol): $\(coin.currentPrice)")
            }
        }
    }
}

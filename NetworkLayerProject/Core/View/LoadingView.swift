//
//  LoadingView.swift
//  NetworkLayerProject
//
//  Created by Vinayak Putta on 16/01/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 20)  {
            Text("")
                .font(.system(size: 80))
            ProgressView()
            Text("Fetching crypto...")
                .foregroundColor(.gray)
        }
    }
}

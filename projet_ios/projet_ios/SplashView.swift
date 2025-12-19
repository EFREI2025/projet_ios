//
//  SplashView.swift
//  projet_ios
//
//  Created by imac12 on 19/12/2025.
//

import Foundation
import SwiftUI

struct SplashView: View {

    @State private var isActive = false

    var body: some View {
        if isActive {
            MainTabView()
        } else {
            VStack(spacing: 20) {
                Image("AppIcon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)

                ProgressView()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .onAppear {
                // Temps de chargement simulé
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}

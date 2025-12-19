//
//  FavoritesView.swift
//  projet_ios
//
//  Created by imac12 on 18/12/2025.
//

import Foundation
import SwiftUI
import SwiftData

struct FavoritesView: View {
    @Query private var statuses: [UserMediaStatus]

    private var favorites: [UserMediaStatus] {
        statuses.filter { $0.isFavorite }
    }

    var body: some View {
        NavigationStack {
            if favorites.isEmpty {
                ContentUnavailableView("Aucun favori", systemImage: "heart")
            } else {
                List(favorites) { s in
                    HStack {
                        if let url = s.posterURL {
                            AsyncImage(url: url) { $0.resizable() } placeholder: { Color.gray }
                                .frame(width: 50, height: 75).cornerRadius(8)
                        }
                        VStack(alignment: .leading) {
                            Text(s.title).font(.headline)
                            if let r = s.rating { Text("⭐️ \(r, specifier: "%.1f")").foregroundStyle(.secondary) }
                        }
                    }
                }
                .navigationTitle("Favoris")
            }
        }
    }
}

//
//  ExplorerViewModel.swift
//  projet_ios
//
//  Created by imac12 on 18/12/2025.
//

import Foundation
import SwiftUI

@MainActor
class ExplorerViewModel: ObservableObject {

    @Published var items: [MediaItem] = []
    @Published var searchText: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = TMDBService()

    var filteredItems: [MediaItem] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }

    func loadTrending() async {
        isLoading = true
        errorMessage = nil

        do {
            items = try await service.fetchTrendingMovies()
        } catch {
            errorMessage = "Erreur lors du chargement"
        }

        isLoading = false
    }
}

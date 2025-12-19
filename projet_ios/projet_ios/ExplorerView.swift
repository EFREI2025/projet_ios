//
//  ExplorerView.swift
//  projet_ios
//
//  Created by imac12 on 18/12/2025.
//

import Foundation
import SwiftUI

struct ExplorerView: View {

    @StateObject private var viewModel = ExplorerViewModel()

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Chargement...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.filteredItems) { item in
                        NavigationLink(value: item) {
                            MediaRowView(item: item)
                        }
                    }
                }
            }
            .navigationTitle("Explorer")
            .searchable(text: $viewModel.searchText)
            .navigationDestination(for: MediaItem.self) { item in
                MediaDetailView(item: item)
            }
        }
        .task {
            await viewModel.loadTrending()
        }
    }
}

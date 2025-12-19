//
//  PlaylistDetailView.swift
//  projet_ios
//
//  Created by imac12 on 19/12/2025.
//

import Foundation
import SwiftUI
import SwiftData

struct PlaylistDetailView: View {

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    let playlist: Playlist

    @State private var showDeleteAlert = false

    var body: some View {
        List {
            // Description
            if let d = playlist.details {
                Text(d)
                    .foregroundStyle(.secondary)
            }

            // Éléments
            ForEach(playlist.items) { it in
                HStack {
                    if let url = it.posterURL {
                        AsyncImage(url: url) { $0.resizable() } placeholder: {
                            Color.gray
                        }
                        .frame(width: 40, height: 60)
                        .cornerRadius(8)
                    }
                    Text(it.title)
                }
            }
            .onDelete { idx in
                idx.map { playlist.items[$0] }
                    .forEach { context.delete($0) }
            }

            // 🔴 Bouton suppression playlist
            Section {
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Label("Supprimer la playlist", systemImage: "trash")
                }
            }
        }
        .navigationTitle(playlist.name)
        .alert("Supprimer la playlist ?", isPresented: $showDeleteAlert) {
            Button("Supprimer", role: .destructive) {
                context.delete(playlist)
                dismiss()
            }
            Button("Annuler", role: .cancel) {}
        } message: {
            Text("Tous les éléments de la playlist seront supprimés.")
        }
    }
}


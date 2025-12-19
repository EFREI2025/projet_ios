//
//  MediaDetailView.swift
//  projet_ios
//
//  Created by imac12 on 18/12/2025.
//



import SwiftUI
import SwiftData

struct MediaDetailView: View {

    let item: MediaItem

    @Environment(\.modelContext) private var context
    @Query private var statuses: [UserMediaStatus]
    @Query private var playlists: [Playlist]

    // Segmented picker
    @State private var selectedState: WatchState = .none

    // Statut existant (s’il existe déjà en base)
    private var status: UserMediaStatus? {
        statuses.first { $0.mediaId == item.id }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {

                // Image
                if let url = item.posterURL {
                    AsyncImage(url: url) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(height: 300)
                }

                // Titre
                Text(item.title)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)

                // ❤️ Favori
                Button {
                    toggleFavorite()
                } label: {
                    Label(
                        (status?.isFavorite ?? false) ? "Retirer des favoris" : "Ajouter aux favoris",
                        systemImage: (status?.isFavorite ?? false) ? "heart.fill" : "heart"
                    )
                }
                .buttonStyle(.borderedProminent)

                // 🎚️ SEGMENTED PICKER (STATUT)
                Picker("Statut", selection: $selectedState) {
                    Text("Aucun").tag(WatchState.none)
                    Text("À voir").tag(WatchState.wantToWatch)
                    Text("Déjà vu").tag(WatchState.watched)
                }
                .pickerStyle(.segmented)
                .onChange(of: selectedState) {
                    setWatch(selectedState)
                }


                // ➕ Ajouter à une playlist
                if !playlists.isEmpty {
                    Menu("Ajouter à une playlist") {
                        ForEach(playlists) { playlist in
                            Button(playlist.name) {
                                addToPlaylist(playlist)
                            }
                        }
                    }
                }

                // Description
                if let overview = item.overview {
                    Text(overview)
                        .padding(.top)
                }
            }
            .padding()
        }
        .navigationTitle(item.title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            // Synchronise le picker avec la valeur en base
            selectedState = status?.watchState ?? .none
        }
    }

  

    private func getOrCreateStatus() -> UserMediaStatus {
        if let s = status {
            return s
        }
        let s = UserMediaStatus(
            mediaId: item.id,
            title: item.title,
            posterPath: item.posterPath,
            rating: item.rating
        )
        context.insert(s)
        return s
    }

    private func toggleFavorite() {
        let s = getOrCreateStatus()
        s.isFavorite.toggle()
    }

    private func setWatch(_ state: WatchState) {
        let s = getOrCreateStatus()
        s.watchState = state
    }

    private func addToPlaylist(_ playlist: Playlist) {
        let newItem = PlaylistItem(
            mediaId: item.id,
            title: item.title,
            posterPath: item.posterPath,
            rating: item.rating
        )
        playlist.items.append(newItem)
    }
}

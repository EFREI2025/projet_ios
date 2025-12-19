import SwiftUI
import SwiftData

struct PlaylistsView: View {

    @Environment(\.modelContext) private var context
    @Query private var playlists: [Playlist]

    @State private var name = ""
    @State private var details = ""

    // 🔴 Alert
    @State private var showDeleteAlert = false
    @State private var playlistToDelete: Playlist?

    var body: some View {
        NavigationStack {
            Form {
                // Création
                Section("Créer une playlist") {
                    TextField("Nom", text: $name)
                    TextField("Description", text: $details)

                    Button("Créer") {
                        context.insert(
                            Playlist(
                                name: name,
                                details: details.isEmpty ? nil : details
                            )
                        )
                        name = ""
                        details = ""
                    }
                    .disabled(name.trimmingCharacters(in: .whitespaces).isEmpty)
                }

                // Liste
                Section("Playlists") {
                    ForEach(playlists) { p in
                        NavigationLink(p.name) {
                            PlaylistDetailView(playlist: p)
                        }
                    }
                    .onDelete { indexSet in
                        if let index = indexSet.first {
                            playlistToDelete = playlists[index]
                            showDeleteAlert = true
                        }
                    }
                }
            }
            .navigationTitle("Playlists")
            .alert("Supprimer la playlist ?", isPresented: $showDeleteAlert) {
                Button("Supprimer", role: .destructive) {
                    if let playlistToDelete {
                        context.delete(playlistToDelete)
                    }
                }
                Button("Annuler", role: .cancel) {}
            } message: {
                Text("Cette action est définitive.")
            }
        }
    }
}

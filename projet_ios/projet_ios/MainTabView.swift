//
//  MainTabView.swift
//  projet_ios
//
//  Created by imac12 on 18/12/2025.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            ExplorerView()
                .tabItem { Label("Explorer", systemImage: "film") }

            FavoritesView()
                .tabItem { Label("Favoris", systemImage: "heart") }

            PlaylistsView()
                .tabItem { Label("Playlists", systemImage: "list.bullet") }

            WatchStatusView()
                .tabItem { Label("Mes listes", systemImage: "checkmark.circle") }

         
        }
    }
}


//
//  projet_iosApp.swift
//  projet_ios
//
//  Created by imac12 on 17/12/2025.
//

import SwiftUI
import SwiftData

@main
struct projet_iosApp: App {
    var body: some Scene {
        WindowGroup {
           
            SplashView()
                .preferredColorScheme(.dark)
        }
        .modelContainer(for: [
            UserMediaStatus.self,
            Playlist.self,
            PlaylistItem.self
        ])
    }
}


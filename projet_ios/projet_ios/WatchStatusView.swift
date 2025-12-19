//
//  WatchStatusView.swift
//  projet_ios
//
//  Created by imac12 on 18/12/2025.
//

import SwiftUI
import SwiftData

enum WatchFilter: String, CaseIterable, Identifiable {
    case all = "Tous"
    case wantToWatch = "À voir"
    case watched = "Déjà vu"

    var id: String { rawValue }
}

struct WatchStatusView: View {

    @Query private var statuses: [UserMediaStatus]
    @State private var selectedFilter: WatchFilter = .all

    var filteredStatuses: [UserMediaStatus] {
        switch selectedFilter {
        case .all:
            return statuses
        case .wantToWatch:
            return statuses.filter { $0.watchState == .wantToWatch }
        case .watched:
            return statuses.filter { $0.watchState == .watched }
        }
    }

    var body: some View {
        NavigationStack {
            VStack {
                // 🎚️ SEGMENTED PICKER (comme sur la diapo)
                Picker("Statut", selection: $selectedFilter) {
                    ForEach(WatchFilter.allCases) { filter in
                        Text(filter.rawValue)
                            .tag(filter)
                    }
                }
                .pickerStyle(.segmented)
                .padding()

                // 📋 Liste filtrée
                List(filteredStatuses) { status in
                    Text(status.title)
                }
            }
            .navigationTitle("Mes listes")
        }
    }
}

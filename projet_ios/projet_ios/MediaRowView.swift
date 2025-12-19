//
//  MediaRowView.swift
//  projet_ios
//
//  Created by imac12 on 18/12/2025.
//

import SwiftUI


struct MediaRowView: View {

    let item: MediaItem

    var body: some View {
        HStack {
            if let url = item.posterURL {
                AsyncImage(url: url) { image in
                    image.resizable()
                } placeholder: {
                    Color.gray
                }
                .frame(width: 50, height: 75)
                .cornerRadius(8)
            }

            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.headline)
                if let rating = item.rating {
                    Text("⭐️ \(rating, specifier: "%.1f")")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

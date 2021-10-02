//
//  AlbumTracksScrollView.swift
//  SpotifyClone
//
//  Created by Gabriel on 9/28/21.
//

import SwiftUI

struct AlbumTracksScrollView: View {
  @EnvironmentObject var mediaDetailVM: MediaDetailViewModel
  var medias: [SpotifyModel.MediaItem] {
    mediaDetailVM.mediaCollection[.album(.tracksFromAlbum)]!
  }

  var body: some View {
    LazyVStack {
      ForEach(medias) { media in
        AlbumItem(title: media.title,
                  author: media.authorName.joined(separator: ", "))
          .onAppear { testIfShouldFetchMoreData(basedOn: media) }
      }
    }
    .padding(.top, 15)
  }

  func testIfShouldFetchMoreData(basedOn media: SpotifyModel.MediaItem) {
    if medias.count > 5 {
      if media.id == medias[medias.count - 4].id {
        MediaDetailViewModel.AlbumAPICalls.getTracksFromAlbum(mediaVM: mediaDetailVM, loadMoreEnabled: true)
      }
    }
  }

  struct AlbumItem: View {
    let title: String
    let author: String

    var body: some View {
      HStack(spacing: 12) {
        VStack(alignment: .leading) {
          Text(title)
            .font(.avenir(.medium, size: 20))
          Text(author)
            .font(.avenir(.medium, size: 16))
            .opacity(0.6)
        }
        Spacer()
        Image("three-dots")
          .resizeToFit()
          .padding(.vertical, 16)
      }
      .frame(height: 60)
      .padding(.bottom, 5)
    }
  }

}




//
//  TuitionView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import Foundation
import SwiftUI
import AVKit
import AVFoundation
import CoreData

struct CourseView: View {
    let moc: NSManagedObject
    var chapters: [Video]?
    
    var body: some View {
        if let chapters {
            List {
                ForEach(chapters, id: \.self) { chapter in
                    NavigationLink {
                        VideoView(videoURL: chapter.videoUrl)
                        
                    } label: {
                        Text(chapter.name)
                    }
                }
            }
            
        } else {
            Text("Loading...")
        }
    }
}

struct VideoView: View {
    let videoURL: URL
    
    @State var player: AVPlayer?
    
    var body: some View {
        VideoPlayer(player: player)
            .task {
                player = AVPlayer(url: videoURL)
            }
    }
}

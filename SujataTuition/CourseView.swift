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
import CloudKit
import CoreData

struct CourseView: View {
    let id: String
    let name: String
    
    @FetchRequest(sortDescriptors: [])
    private var courses: FetchedResults<Course>
   
    var body: some View {
        Group {
//            let _ = print("courses: \(courses)")
//            let _ = print("id: \(id) course: \(String(describing: courses.first?.id))")
            if let course = courses.first {
                let chapters = course.chapters as? Set<Chapter> ?? []
                
                List {
                    ForEach(chapters.sorted { $0.name! < $1.name! }) { chapter in
                        let chapterName = chapter.name!
                        NavigationLink {
                            ChapterView(name: chapterName)
                            
                        } label: {
                            Text(chapterName)
                        }
                    }
                }
                .navigationTitle(name)
                
            } else {
                Text("Loading...")
            }
        }
        .task {
            courses.nsPredicate = .init(format: "id == %@", id)
        }
    }
}

enum LoadingState<T> {
    case error(Error)
    case loading(Double)
    case loaded(T)
}

extension LoadingState {
    func map<U>(_ f: (T) -> U) -> LoadingState<U> {
        switch self {
        case .error(let error): .error(error)
        case .loading(let loading): .loading(loading)
        case .loaded(let item): .loaded(f(item))
        }
    }
}

struct ChapterView: View {
    let name: String

    @State var state = LoadingState<AVPlayer>.loading(0)

    var body: some View {
        Group {
            switch state {
            case .error(let error):
                Text("Error loading \(name): \(error)")
                
            case .loading(let progress):
                Text("Loading \(name): \(progress)")
                
            case .loaded(let player):
                VideoPlayer(player: player)
            }
        }
        .task {
            do {
                for try await result in PersistenceController.shared.video(forChapterWithName: name) {
                    state = result.map { AVPlayer(url: $0) }
                }

            } catch {
                state = .error(error)
            }
        }
    }
}

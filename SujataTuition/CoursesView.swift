//
//  CourseView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 26/05/24.
//

import Foundation
import SwiftUI
import MessageUI
import CoreData
import StoreKit

extension CoursesView.ItemViewModel: Identifiable {
    public var id: String { course.name! }
}

struct CoursesView: View {
    struct ItemViewModel {
        let course: Course
        let isPurchased: Bool
    }

    let moc: NSManagedObjectContext
    @State var courses: [ItemViewModel]?
    
    var body: some View {
        Group {
            if let courses {
                List {
                    ForEach(courses) { item in
                        HStack {
                            Text(item.course.name!)
                            
                            Spacer()
                            
                            Button {
                                Task {
                                    //                            try await storeKit.purchase(product)
                                }
                            } label: {
                                if item.isPurchased {
                                    Text(Image(systemName: "checkmark"))
                                        .bold()
                                        .padding(10)
                                } else {
                                    Text(item.course.name!)
                                        .padding(10)
                                }
                            }
                        }
                    }
                }
                .padding(5)
                
            } else {
                Text("Loading...")
            }
        }
        .task {
            courses = try? moc.fetch(Course.fetchRequest()).map {
                ItemViewModel(course: $0, isPurchased: false)
            }
        }
    }
    
//    struct ItemView: View {
//        @ObservedObject var storeKit: StoreKitManager
//        
//        var product: Product
//        
//        var body: some View {
//            VStack{
//            }
//            .onChange(of: storeKit.purchasedProducts) { oldProducts, products in
//                Task {
//                    isPurchased = (try? await storeKit.isPurchased(product)) ?? false
//                }
//            }
//        }
//    }
}

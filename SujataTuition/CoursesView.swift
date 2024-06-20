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

extension EnrollView.ItemViewModel: Identifiable {
    public var id: String { course.name }
}

struct EnrollView: View {
    struct ItemViewModel {
        let course: Course
        let isPurchased: Bool
    }

    let moc: NSManagedObjectContext
    @State var courses: [ItemViewModel]?
    
    var body: some View {
        VStack {
            if let courses {
                ForEach(courses) { item in
                    HStack {
                        Text(item.course.name)
                        
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
                                Text(item.course.displayPrice)
                                    .padding(10)
                            }
                        }
                    }
                }
                .padding()
                
            } else {
               Text("Loading...")
            }
        }
        .task {
            courses = moc.fetch(Course.fetchRequest()).map {
                ItemViewModel(course: $0, isPurchased: false)
            }
        }
    }
    
    struct CourseItem: View{
        @ObservedObject var storeKit: StoreKitManager
        @State var isPurchased: Bool = false
        var product: Product
        
        var body: some View{
            VStack{
            }
            .onChange(of: storeKit.purchasedCourses) { oldCourse, course in
                Task{
                    isPurchased = (try? await storeKit.isPurchased(product)) ?? false
                }
            }
        }
    }
}

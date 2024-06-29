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
    public var id: String { product.displayName }
}

struct CoursesView: View {
    struct ItemViewModel {
        let product: Product
        let isPurchased: Bool
    }

    @StateObject var storeKitManager = StoreKitManager()
    @State var items: [ItemViewModel]?
    
    var body: some View {
        Group {
            if let items {
                List {
                    ForEach(items) { item in
                        if item.isPurchased {
                            NavigationLink {
                                CourseView(id: item.product.id, name: item.product.displayName)
                                
                            } label: {
                                Text(item.product.displayName)
                            }

                        } else {
                            HStack {
                                Text(item.product.displayName)
                                Spacer()
                                Button {
                                    Task {
                                        let _ = try await storeKitManager.purchase(item.product.id)
                                    }
                                } label: {
                                    Text(item.product.displayPrice)
                                        .padding(10)
                                }
                            }
                        }
                    }
                }

            } else {
                Text("Loading...")
            }
        }
        .onChange(of: storeKitManager.productsById) {
            update()
        }
        .onChange(of: storeKitManager.purchasedProducts) {
            update()
        }
    }
           
    func update() {
        items = storeKitManager.productsById?.values.map {
            ItemViewModel(product: $0, isPurchased: storeKitManager.purchasedProducts?.contains($0) ?? false)
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

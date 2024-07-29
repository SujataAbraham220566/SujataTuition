//
//  StoreKitManager.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 25/05/24.
//

import Foundation
import StoreKit
import OSLog

private let logger = Logger.init(subsystem: "SujataTuition", category: "StoreKitManager")

class StoreKitManager: ObservableObject {
    private var updateTask: Task<Void, Error>? = nil
    
    init() {
        Task { @MainActor in
            productsById = await {
                let products = try! await Product.products(for: Self.productIds())
                return Dictionary(grouping: products) { $0.id }.mapValues { $0.first! }
            }()
            
            await self.updatePurchasedProducts()
            
            updateTask = Task.detached { [weak self] in
                for await verificationResult in Transaction.updates {
                    guard case .verified(_) = verificationResult else { continue }
                    await self?.updatePurchasedProducts()
                }
            }
        }
    }
    
    // TODO: get this from the public CloudKit
    private static func productIds() async -> [String] {
        [ "com.SujataTuition.SixthMaths",
          "com.SujataTuition.SixthPhysics",
          "com.SujataTuition.SixthChemistry"]
    }
  
    @MainActor @Published var productsById: [String: Product]?
    @MainActor @Published var purchasedProducts: Set<Product>?
//        didSet {
//            purchasedCourses = if let purchasedProducts {
//                purchasedProducts.map {
//                }
//            } else {
//                nil
//            }
//        }
//    }
   
    @MainActor
    private func updatePurchasedProducts() async {
        var purchasedProducts = Set<Product>()
        
        for await verificationResult in Transaction.currentEntitlements {
            guard case .verified(let transaction) = verificationResult else { continue }
            guard let product = productsById![transaction.productID] else { continue }
            purchasedProducts.insert(product)
            await transaction.finish()
        }
        
        self.purchasedProducts = purchasedProducts
    }
    
    deinit {
        updateTask?.cancel()
    }
    
    @MainActor
    func purchase(_ productId: String) async throws -> Transaction? {
        guard let product = productsById![productId] else {
            throw NSError(domain: "bad productId", code: 0xDEAD)
        }
        
        guard case .success(let verificationResult) = try await product.purchase() else {
            return nil
        }
        
        guard case .verified(let transaction) = verificationResult else {
            return nil
        }
        
        return transaction
    }
}

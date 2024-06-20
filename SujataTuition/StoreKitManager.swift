//
//  StoreKitManager.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 25/05/24.
//

import Foundation
import StoreKit

class StoreKitManager: ObservableObject {
    private var updateTask: Task<Void, Error>? = nil
    
    init() {
        Task {
            productsById = await {
                let products = try! await Product.products(for: Self.productIds())
                return Dictionary(grouping: products) { $0.id }.mapValues { $0.first! }
            }()
            
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
        [ "com.SujataTuition.SixthChemistry",
          "com.SujataTuition.SixthMaths" ]
    }
   
    @Published var productsById: [String: Product]?
    @Published var purchasedProducts: Set<Product>?
   
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

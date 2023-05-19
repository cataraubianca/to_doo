//
//  EncodableExtension.swift
//  To_do
//
//  Created by Catarau, Bianca on 19.04.2023.
//

import Foundation

extension Encodable {
    
        var dictionary: [String: Any]? {
        
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
        
    }
    
}

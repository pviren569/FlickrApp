//
//  Extension+String.swift
//  FlickrApp
//
//  Created by Patel, Viren on 3/13/25.
//

import Foundation

extension String {
    var formatReadbleDate: String? {
        let inputFormatter = ISO8601DateFormatter()
        if let date = inputFormatter.date(from: self) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateStyle = .medium
            outputFormatter.timeStyle = .short
            return outputFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    var htmlToAttributedString: AttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        do {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            return AttributedString(attributedString)
        } catch {
            print("Error converting HTML to AttributedString: \(error)")
            return nil
        }
    }
}

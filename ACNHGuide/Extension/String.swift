//
//  String.swift
//  ACNHGuide
//
//  Created by Mickael PAYAN on 09/01/2023.
//

import Foundation

extension String {
    
    var localized: String {
          return NSLocalizedString(self, comment:"")
      }
    
    func replaceCharacter(_ oldString: String, by newString: String) -> String {
        let newString = self.replacingOccurrences(of: oldString, with: newString, options: .literal, range: nil)
        return newString
    }
}

//
//  Extensions.swift
//  TheMovieDB
//
//  Created by Sinuhé Ruedas on 12/10/22.
//

import UIKit

extension UITextField {
   
   enum PaddingSide {
      case both(CGFloat)
   }
   
   func addPadding(_ padding: PaddingSide) {
      
      self.leftViewMode = .always
      self.layer.masksToBounds = true
      
      switch padding {
         case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
      }
   }
}

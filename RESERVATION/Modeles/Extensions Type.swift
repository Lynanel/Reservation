//
//  Extensions Type.swift
//  Codabee
//
//  Created by Matthieu PASSEREL on 20/08/2018.
//  Copyright © 2018 Matthieu PASSEREL. All rights reserved.
//

import UIKit

extension String {
    
    func getDate() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = DATE_FORMAT
        formatter.locale = Locale(identifier: LOCALE)
        return formatter.date(from: self) ?? Date()
    }
    
    func ilYA() -> String {
        let date = getDate()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.month, .day, .hour, .minute], from: date, to: Date())
        let month = components.month ?? 0
        let day = components.day ?? 0
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        
        var base = "Il y a "
        
        if month > 0 {
            return base + String(month) + " mois"
        }
        
        if day > 0 {
            base = base + String(day) + " jour"
            if day > 1 {
                base += "s"
            }
            return base
        }
        
        if hour > 0 {
            base = base + String(hour) + " heure"
            if hour > 1 {
                base += "s"
            }
            return base
        }
        
        if minute > 0 {
            base = base + String(minute) + " minute"
            if minute > 1 {
                base += "s"
            }
            return base
        }
        

        return "A l'instant"
    }
    
    
    
    func height(_ width: CGFloat, font: UIFont) -> CGFloat {
        let size = CGSize(width: width, height: .greatestFiniteMagnitude)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let boundingBox = NSString(string: self).boundingRect(with: size, options: options, attributes: [.font: font], context: nil)
        return boundingBox.height
    }
    
}


extension Date {
    
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = DATE_FORMAT
        formatter.locale = Locale(identifier: LOCALE)
        return formatter.string(from: self)
    }
    
    
}

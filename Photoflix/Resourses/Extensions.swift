//
//  Extensions.swift
//  Photoflix
//
//  Created by Liubov Kurets on 28/07/2022.
//

import Foundation

extension String {
    func capitalizeFirtsLetter()-> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst() 
    }
}

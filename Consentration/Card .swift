 //
//  Card .swift
//  Consentration
//
//  Created by Анастасия Стрекалова on 29.10.2019.
//  Copyright © 2019 Анастасия Стрекалова. All rights reserved.
//

import Foundation
 
struct Card{
    var isFaceup = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private  static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
 }

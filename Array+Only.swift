//
//  Array+Only.swift
//  Memorize
//
//  Created by Muskaan Agrawal on 10/26/20.
//  Copyright © 2020 Muskaan Agrawal. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}

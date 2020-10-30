//
//  InteractionUtil.swift
//  ZikZok
//
//  Created by temp-4400 on 25/10/20.
//  Copyright © 2020 temp-4400. All rights reserved.
//

import Foundation
import UIKit

struct InteractionUtil {
    
    static func pauseUserInteraction() {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    static func resumeUserInteraction() {
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}

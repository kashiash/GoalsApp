//
//  GoalViewModel.swift
//  GoalsApp
//
//  Created by DevTechie on 10/2/21.
//

import Foundation
import UIKit
import SwiftUI

struct GoalViewModel {
    var goal: Goal
    
    var id: String {
        goal.id ?? ""
    }
    
    var name: String {
        goal.name
    }
    
    var dueOnDate: Date {
        goal.dueOn
    }
    
    var dueOn: String {
        goal.dueOn.toRelativeDate()
    }
    
    var color: Color {
        Color(UIColor(hexString: goal.color))
    }
    
    var icon: String {
        goal.icon
    }
    
    var items: [String] {
        get {
            return goal.items
        }
        
        set(newItems) {
            goal.items = newItems
        }
    }
}

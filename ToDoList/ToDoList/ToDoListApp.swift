//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Wang on 2025/12/6.
//

import SwiftUI

@main
struct ToDoListApp: App {
    
    let vm = ListsViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ListView()
                    .environmentObject(vm)
            }
        }
    }
}

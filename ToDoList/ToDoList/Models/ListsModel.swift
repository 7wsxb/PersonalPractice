//
//  ListsModel.swift
//  ToDoList
//
//  Created by Wang on 2025/12/6.
//

import Foundation

//MARK：不可变结构体
struct ListsModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool = false){
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func update() -> Self {
        return ListsModel(id: id, title: title, isCompleted: !isCompleted)
    }
    
}

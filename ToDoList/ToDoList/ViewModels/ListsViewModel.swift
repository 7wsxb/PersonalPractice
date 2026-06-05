//
//  ListsViewModel.swift
//  ToDoList
//
//  Created by Wang on 2025/12/6.
//

import Foundation
import SwiftUI

class ListsViewModel: ObservableObject {
    
    @Published var showGetAlert: Bool = false
    @Published var lists: [ListsModel] = [] {
        didSet {
            saveLists()
        }
    }
    
    init() {
        getLists()
    }
    
    func getLists() {
        if let data = UserDefaults.standard.data(forKey: "lists") {
            lists = try! JSONDecoder().decode([ListsModel].self, from: data)
        }else if !lists.isEmpty{
            showGetAlert.toggle()
        }
    }
    
    func saveLists() {
        if let data = try? JSONEncoder().encode(lists) {
            UserDefaults.standard.set(data, forKey: "lists")
        }
    }
    
    func addList(title: String) {
        let newList = ListsModel(title: title, isCompleted: false)
        lists.append(newList)
    }
    
    func moveList(from: IndexSet, to: Int) {
        lists.move(fromOffsets: from, toOffset: to)
    }
    
    func deleteList(at offsets: IndexSet) {
        lists.remove(atOffsets: offsets)
    }
    
    func updateList(list: ListsModel) {
        guard
        let index = lists.firstIndex(where: { $0.id == list.id })
            else { return }
        lists[index] = list.update()
    }
    
}

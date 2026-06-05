//
//  ListRowView.swift
//  ToDoList
//
//  Created by Wang on 2025/12/6.
//

import SwiftUI

struct ListRowView: View {
    
    var list: ListsModel
    
    var body: some View {
        HStack {
            Text(list.title)
                .font(.headline.bold())
            Spacer()
            Image(systemName: "checkmark.circle")
                .font(.title)
                .foregroundStyle(list.isCompleted ? .green : .gray)
        }
    }
}

#Preview {
    ListRowView(list: ListsModel(id: "1", title: "Test", isCompleted: true))
}

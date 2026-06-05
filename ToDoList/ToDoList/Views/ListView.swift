//
//  ListView.swift
//  ToDoList
//
//  Created by Wang on 2025/12/6.
//

import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var vm: ListsViewModel
    
    var body: some View {
        ZStack {
            if vm.lists.isEmpty {
                NoListView()
                    .navigationTitle(Text("Welcome to SuJi!"))
            } else {
                List {
                    ForEach(vm.lists) { list in
                        ListRowView(list: list)
                            .onTapGesture {
                                vm.updateList(list: list)
                            }
                    }
                    .onMove { indexSet, endTo in
                        vm.moveList(from: indexSet, to: endTo)
                    }
                    .onDelete { index in
                        vm.deleteList(at: index)
                    }
                }
                .alert(isPresented: $vm.showGetAlert) {
                    Alert(title: Text("获取数据出错"),
                          dismissButton: .cancel()
                    )
                }
                .foregroundStyle(
                    LinearGradient(colors: [.yellow, .purple],
                                   startPoint: .topLeading,
                                   endPoint: .bottomTrailing)
                )
                .listStyle(.plain)
                .navigationTitle(Text("My Lists"))
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AddView()) {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        EditButton()
                    }
                }
            }
        }
    }
}

#Preview {
    ListView()
}

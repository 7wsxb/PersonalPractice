//
//  AddView.swift
//  ToDoList
//
//  Created by Wang on 2025/12/6.
//

import SwiftUI

struct AddView: View {
    
    @State private var text: String = ""
    @EnvironmentObject var vm: ListsViewModel
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack {
            TextField("Add a new item", text: $text)
                .font(.system(size: 20))
                .padding(10)
                .background(Color.gray.opacity(0.2)).cornerRadius(10)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("You can not save.💩 Please enter more than 3 characters!"),
                          dismissButton: .cancel(Text("OK")))
                }
            
            if text.count <= 3 && text != "" {
                Text("Please enter more than 3 characters!")
                    .foregroundColor(.red)
            }
            
            Button {
                if text.count > 3 {
                    vm.addList(title: text)
                }else {
                    showAlert.toggle()
                }
                text = ""
            } label: {
                Text("SAVE")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background( text.count > 3 ? Color.blue : Color.gray)
                    .cornerRadius(15)
            }

            Spacer()
            
            AddedListView(text: $text)
            
            Spacer()
                
        }
        .padding(10)
        .padding(.top, 20)
    }
}

struct AddedListView: View {
    
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
                Text("New Plan: \(text)")
                    .font(.title)
                    .foregroundStyle(.orange.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    AddView()
}

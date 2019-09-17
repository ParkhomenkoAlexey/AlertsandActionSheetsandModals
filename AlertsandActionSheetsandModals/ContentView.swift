//
//  ContentView.swift
//  AlertsandActionSheetsandModals
//
//  Created by Алексей Пархоменко on 17/09/2019.
//  Copyright © 2019 Алексей Пархоменко. All rights reserved.
//

import SwiftUI

struct Message: Identifiable {
    let id = UUID()
    let text: String
}

struct ContentView: View {
    @State private var showActionSheet = false
    @State private var message: Message? = nil
    @State private var showModal = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                self.showModal = true
            }, label: {
                Text("Show ModalView")
                }).sheet(isPresented: $showModal, onDismiss: {
                    print(self.showModal)
                }, content: {
                    ModalView(message: "This is ModelView")
                })
            Button(action: {
                self.message = Message(text: "Hi!")
            }, label: {
                Text("Show alert")
                }).alert(item: $message, content: { message in
                    Alert(title: Text(message.text), dismissButton: .cancel())
                })
            Button(action: {
                self.showActionSheet = true
            }, label: {
                Text("Show action sheet")
            }).actionSheet(isPresented: $showActionSheet, content: {
                ActionSheet(title: Text("Actions"),
                            message: Text("Available actions"),
                            buttons: [
                                .cancel({print(self.showActionSheet)}),
                                .default(Text("Action")),
                                .destructive(Text("Delete"))
                                
                ])
            })
        }
    }
}

struct ModalView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let message: String
    
    var body: some View {
        VStack {
            Text(message)
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Dismiss")
            })
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

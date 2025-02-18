//
//  SpartieMessagesAdvApp.swift
//  SpartieMessagesAdv
//
//  Created by Ming on 2/14/25.
//

import SwiftUI

@main
struct SpartieMessagesAdvApp: App {
    @StateObject private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}

//
//  ContentView.swift
//  VarolantVersus
//
//  Created by KENGO on 2020/08/30.
//  Copyright © 2020 KENGO NISHIMURA. All rights reserved.
//

import SwiftUI
import RealmSwift
import UIKit

struct ContentView: View {

    var body: some View {
        TabView {
            
                MainView()
                
                .tabItem {
                    IconView(systemName: "house")
                }
            

            UpdatePage(url: URL(string: "https://playvalorant.com/en-us/")!)
            .tabItem {
                IconView(systemName: "doc.append")
            }
            
        }


    }
    
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            ContentView().environment(\.locale, Locale(identifier: "en"))
            ContentView().environment(\.locale, Locale(identifier: "ja"))
        }
        
    }
}


struct IconView: View {
    var systemName: String

    var body: some View {
        Image(systemName: systemName)
            .font(.title)
    }
}

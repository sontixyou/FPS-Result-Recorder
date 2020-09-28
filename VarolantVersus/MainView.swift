//
//  MainView.swift
//  TodoUI
//
//  Created by KENGO on 2020/08/12.
//  Copyright © 2020 KENGO NISHIMURA. All rights reserved.
//

import SwiftUI
import UIKit
import RealmSwift
import Combine

//data list
class MyModel: Object {
    @objc dynamic var id = UUID().uuidString
    @objc dynamic var title = ""
    @objc dynamic var Match_win_count = ""
    @objc dynamic var Match_lose_count = ""
    @objc dynamic var KillRate_kill_count = ""
    @objc dynamic var KillRate_dead_count = ""
}

class ContentViewModel: ObservableObject {
    private var token: NotificationToken?
    private var myModelResults = try? Realm().objects(MyModel.self)
    @Published var cellModels: [ContentViewCellModel] = []
    
    init() {
        token = myModelResults?.observe { [weak self] _ in
            self?.cellModels = self?.myModelResults?.map { ContentViewCellModel(
                id: $0.id
                , title: $0.title
                ,Match_win_count:$0.Match_win_count
                ,Match_lose_count:$0.Match_lose_count
                ,KillRate_kill_count :$0.KillRate_kill_count
                ,KillRate_dead_count :$0.KillRate_dead_count
                
            ) } ?? []
        }
    }
    
    deinit {
        token?.invalidate()
    }
}

struct ContentViewCellModel {
    let id: String
    let title: String
    
    let Match_win_count:String
    let Match_lose_count:String
    let KillRate_kill_count :String
    let KillRate_dead_count :String
}


class screenChange:ObservableObject {
    @Published var screenValues = false
    @Published var write = false
}

struct MainView: View {
    @ObservedObject var model = ContentViewModel()
    @ObservedObject var InputScreenpresent = screenChange()
    var body: some View {
        
        ZStack{
            NavigationView {
                List {
                    ForEach(model.cellModels, id: \.id) { cellModel in
                        
                        VStack(alignment: .leading){
                            Text("Match Result                      ").font(.largeTitle)
                            Text(" Match:\(cellModel.Match_win_count)-\(cellModel.Match_lose_count)")
                            Text( " Killlog:\(cellModel.KillRate_kill_count)-\(cellModel.KillRate_dead_count)")
                            
                        }.background(Color.green)
                        
                    }.onDelete { indexSet in
                        let realm = try? Realm()
                        if let index = indexSet.first,
                           let myModel = realm?.objects(MyModel.self).filter("id = %@", self.model.cellModels[index].id).first {
                            try? realm?.write {
                                realm?.delete(myModel)
                            }
                            
                            
                        }
                    }
                }.navigationBarTitle("Varolant")
                .navigationBarItems(
                    
                    trailing: Button(action:
                                        addButton
                                     
                    ) {
                        Text("Add")
                    })
                
            }.sheet(isPresented: $InputScreenpresent.screenValues) {
                InputScreen(
                    
                    InputScreenpresent: self.InputScreenpresent).transition(.move(edge: .bottom))
            }
        }
        
    }
    
    func addButton(){
        self.InputScreenpresent.screenValues = true
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            MainView().environment(\.locale, Locale(identifier: "en"))
            MainView().environment(\.locale, Locale(identifier: "ja"))
        }
    }
}

//input screen
struct InputScreen: View {
    
    @State var Win_Round = ""
    @State var Lose_Round = ""
    @State var Kill_Count = ""
    @State var Dead_Count = ""
    @ObservedObject var InputScreenpresent : screenChange
    
    var isEnabled_Win_Round: Bool{
        if Win_Round.count > 0 && Lose_Round.count > 0 && Kill_Count.count > 0
            && Dead_Count.count > 0{
            return true
        }else{
            return false
        }
    }
    var body: some View {
        ZStack{
            Color.white
                .onTapGesture {
                    UIApplication.shared.CloseKeyboard()
                }
            
            VStack {
                VStack {
                    VStack {
                        HStack {
                            VStack {
                                Text("Win Round").foregroundColor(.black)
                                TextField("Win Round", text: $Win_Round).frame(width: 150, height: 40).keyboardType(.phonePad).background(Color.gray).onReceive(Just(Win_Round)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.Win_Round = filtered
                                    }
                                }
                            }
                            VStack {
                                Text("Lose Round").foregroundColor(.black)
                                TextField("Lose Round", text: $Lose_Round).frame(width: 150, height: 40).keyboardType(.phonePad).background(Color.gray).onReceive(Just(Lose_Round)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.Lose_Round = filtered
                                    }
                                }
                            }
                        }
                        HStack {
                            VStack {
                                Text("Kill Count").foregroundColor(.black)
                                TextField("Kill Count", text: $Kill_Count).frame(width: 150, height: 40).keyboardType(.phonePad).background(Color.gray).onReceive(Just(Kill_Count)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.Kill_Count = filtered
                                    }
                                }
                            }
                            VStack {
                                Text("Dead Count").foregroundColor(.black)
                                TextField("Dead Count", text: $Dead_Count
                                ).frame(width: 150, height: 40).keyboardType(.phonePad).background(Color.gray).onReceive(Just(Dead_Count)) { newValue in
                                    let filtered = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        self.Dead_Count = filtered
                                    }
                                }
                            }
                        }
                    }
                    
                }
                Button(action:
                        submit
                ) {
                    Text("Input").disabled(!self.isEnabled_Win_Round)
                }
            }
        }.navigationBarItems(
            leading:
                
                Button(action:
                        ReturnButton
                ) {
                    Text("Return")
                }
        )
        
    }
    func ReturnButton(){
        self.InputScreenpresent.screenValues = false
        
    }
    //戦績登録ボタンの処理内容
    func submit() -> Void {
        guard self.isEnabled_Win_Round else {
            return
        }
        print("hello world")
        let myModel = MyModel()
        
        if self.Win_Round != "" &&
            self.Lose_Round != "" &&
            self.Kill_Count != "" &&
            self.Dead_Count != "" {
            myModel.title = "\(Date())"
            myModel.Match_win_count = self.Win_Round
            myModel.Match_lose_count = self.Lose_Round
            myModel.KillRate_kill_count = self.Kill_Count
            myModel.KillRate_dead_count = self.Dead_Count
        }
        
        let realm = try? Realm()
        try? realm?.write {
            realm?.add(myModel)
        }
        print(myModel.self)
        
        self.InputScreenpresent.write = true
        self.InputScreenpresent.screenValues = false
    }
}

extension UIApplication{
    func CloseKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}





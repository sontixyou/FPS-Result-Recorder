//
//  InputScreen.swift
//  TodoUI
//
//  Created by KENGO on 2020/08/12.
//  Copyright © 2020 KENGO NISHIMURA. All rights reserved.
//

import SwiftUI


struct InputScreen: View {
 
    @State var Win_Round = ""
    @State var Lose_Round = ""
    @State var Kill_Count = ""
    @State var Dead_Count = ""
////    @Binding var Id:[Int] = [0,1,2,3,4,5,6,7,8,9,10]
////       @Binding var Match_win_count:[Int] = [13,13,13,13,13,13,4,5,6,7,8]
////       @Binding var Match_lose_count:[Int] = [6,7,8,3,4,13,13,13,13,13,13]
////       @Binding var KillRate_kill_count :[Int] = [20,10,30,15,20,10,30,15,20,10,30]
////       @Binding var KillRate_dead_count :[Int] = []
////       @Binding var Date:[String] = []
//  
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
                                Text("勝ちラウンド").foregroundColor(.black)
                                TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $Win_Round).keyboardType(.phonePad).background(Color.gray)
                            }
                            VStack {
                                Text("負けラウンド").foregroundColor(.black)
                                TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $Lose_Round).keyboardType(.phonePad).background(Color.gray)
                            }
                        }
                        HStack {
                            VStack {
                                Text("殺した数").foregroundColor(.black)
                                TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $Kill_Count).keyboardType(.phonePad).background(Color.gray)
                            }
                            VStack {
                                Text("死んだ数").foregroundColor(.black)
                                TextField(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/, text: $Dead_Count
                                ).keyboardType(.phonePad).background(Color.gray)
                            }
                        }
                    }
                    
                }
                Button(action: {
                    print("hello world")
                    
                }
                ) {
                    Text("入力完了")
                }
            }
        }
    }
    
    
    
}

  
    func addResult(){
        if Int(self.Win_Round)!  >= 0 && Int(self.Lose_Round)!  >= 0 && Int(self.Kill_Count)!  >= 0 && Int(self.Dead_Count)! >= 0{
            self.Id_data.Id.append(UUID().uuidString)
            self.Id_data.Match_win_count.append(Int(self.Win_Round)!)
            self.Id_data.Match_lose_count.append(Int(self.Lose_Round)!)
            self.Id_data.KillRate_kill_count.append(Int(self.Kill_Count)!)
            self.Id_data.KillRate_dead_count.append(Int(self.Dead_Count)!)

            print("\(self.Id_data.Id)")
            print("\(self.Id_data.Match_win_count)")
            print("\(self.Id_data.Match_lose_count)")

            print("\(self.Id_data.KillRate_kill_count)")
            print("\(self.Id_data.KillRate_dead_count)")
            self.Win_Round = ""
            self.Lose_Round = ""
            self.Kill_Count = ""
            self.Dead_Count = ""
        }else{
            print("data is Nothing")
        }
    }




extension UIApplication{
    func CloseKeyboard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}



struct InputScreen_Previews: PreviewProvider {
    static var previews: some View {
        InputScreen()
    }
}

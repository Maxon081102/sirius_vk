//
//  ContentView.swift
//  TestVk
//
//  Created by Максим Никитин on 7/13/22.
//

import SwiftUI

struct ContentView: View {
    @State var basicLinks:[String : String] = [
        "ВКонтакте": "https://vk.com/",
        "My.Games": "https://my.games/",
        "Самокат": "https://samokat.ru/",
        "Сферум": "https://sferum.ru/?p=start",
        "Юла": "https://youla.ru/",
        "Ситидрайв": "https://citydrive.ru/",
        "Облако": "https://cloud.mail.ru/home/",
        "Все аптеки": "https://vseapteki.ru/",
        "Календарь": "https://calendar.mail.ru/"]
    @State var apps: [AppVK] = []
    @State var biggerApp: Bool = false
    @State var proFile: Bool = false
    @State var viewState = CGSize.zero
    let screen = UIScreen.main.bounds
    
    init(){
        UITableView.appearance().backgroundColor = .white
    }
    var body: some View {
        ZStack {
            
            HomeView(proFile: $proFile, apps: $apps, basicLinks: $basicLinks)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
                .scaleEffect(proFile ? 0.9 : 1)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 20)
                .offset(y: proFile ? -450 : 0)
                .rotation3DEffect(Angle(degrees: proFile ? -10 : 0), axis: (x: 10, y: 0, z: 0))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    self.proFile.toggle()
                }
            
            MenuView()
                .offset(y: proFile ? 0 : screen.height)
                .offset(y: viewState.height)
                .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture {
                    self.proFile.toggle()
                }
                .gesture(DragGesture()
                    .onChanged{ Value in
                        self.viewState = Value.translation
                        if self.viewState.height > 50 {
                            self.proFile = false
                        }
                    }
                    .onEnded{ Value in
                        self.viewState = .zero
                    }
                )
            
        }
        
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

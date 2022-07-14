//
//  ContentView.swift
//  TestVk
//
//  Created by Максим Никитин on 7/13/22.
//

import SwiftUI

struct ContentView: View {
    @State var apps: [AppVK] = []
    
    init(){
        UITableView.appearance().backgroundColor = .white
    }
    var body: some View {
        NavigationView {
            List(0..<apps.count, id: \.self){ i in
                HStack(alignment: .center){
                    AsyncImage(url: URL(string: apps[i].icon_url)){
                        image in
                        image.resizable()
                        } placeholder: {
                            Color((UIColor(red: 0.91, green: 0.26, blue: 0.58, alpha: 1.00)))
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 65, height: 65)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .background(RoundedRectangle(cornerRadius: 18)
                            .fill(Color.white)
                            .frame(width: 70, height: 70))
                        .padding(1)
                    VStack(alignment: .leading) {
                        Text(apps[i].name)
                            .bold()
                            .lineLimit(nil)
                            .foregroundColor(.white)
                        Text(apps[i].description)
                            .font(.system(size: 16))
                            .lineLimit(nil)
                            .foregroundColor(.white)
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.title)
                        .foregroundColor(Color(.white))
                    
                }
                .frame(height: 120)
                .padding()
                .listRowBackground(Color(UIColor(red: 0.91, green: 0.26, blue: 0.58, alpha: 1.00)))
                .listRowSeparatorTint(.white)
                .onTapGesture{
                    if UIApplication.shared.canOpenURL(URL(string: apps[i].link)!){
                        UIApplication.shared.open(URL(string: apps[i].link)!)
                    } else {
                        UIApplication.shared.open(URL(string: apps[i].link)!)
                    }
                }
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                ToolbarItem(placement: .principal) {
                    VStack {
                        Text("Сервисы VK")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(.black))
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear(){
                Api().getApps{(apps) in
                    self.apps = apps
                }
            }
            .padding(.bottom, -72)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

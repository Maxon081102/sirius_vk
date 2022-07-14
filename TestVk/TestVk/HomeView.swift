//
//  HomeView.swift
//  TestVk
//
//  Created by Максим Никитин on 7/14/22.
//

import SwiftUI

struct HomeView: View {
    @Binding var proFile: Bool
    @Binding var apps:[AppVK]
    @Binding var basicLinks:[String: String]
    var body: some View {
        VStack{
            UpView(proFile: $proFile)
            List(0..<apps.count, id: \.self){ i in
                ShowAppCard(basicLinks: $basicLinks, AppVK: $apps[i])
            }
            .clipShape(RoundedRectangle(cornerRadius: 40))
            .listStyle(PlainListStyle())
            .onAppear(){
                Api().getApps{(apps) in
                    self.apps = apps
                }
            }
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(proFile: .constant(false), apps: .constant([]), basicLinks: .constant([:]))
    }
}


struct AvatarView: View {
    @Binding var proFile: Bool
    var body: some View {
        Button(action: {
            self.proFile.toggle()
        }){
            Image("me")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
        }
    }
}

struct ShowIcon: View {
    @Binding var icon_url: String
    var body: some View{
        AsyncImage(url: URL(string: icon_url)){
            image in
            image.resizable()
        } placeholder: {
            Image("scale_1200")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .aspectRatio(contentMode: .fit)
        .frame(width: 65, height: 65)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .background(RoundedRectangle(cornerRadius: 18)
            .fill(Color.white)
            .frame(width: 70, height: 70))
        .padding(1)
    }
}

struct ShowText: View {
    @Binding var name: String
    @Binding var description: String
    var body: some View{
        VStack(alignment: .leading) {
            Text(name)
                .bold()
                .lineLimit(nil)
                .foregroundColor(.white)
            Text(description)
                .font(.system(size: 16))
                .lineLimit(nil)
                .foregroundColor(.white)
        }
    }
}

struct ShowAppCard: View {
    @Binding var basicLinks:[String: String]
    @Binding var AppVK: AppVK
    var body: some View{
        HStack(alignment: .center){
            ShowIcon(icon_url: $AppVK.icon_url)
            ShowText(name: $AppVK.name, description: $AppVK.description)
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
            if UIApplication.shared.canOpenURL(URL(string: AppVK.link)!){
                UIApplication.shared.open(URL(string: AppVK.link)!)
            } else {
                UIApplication.shared.open(URL(string: basicLinks[AppVK.name] ?? "https://vk.com/")!)
            }
        }
        
    }
}

struct UpView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var proFile: Bool
    var body: some View {
        VStack {
            HStack {
                AvatarView(proFile: $proFile )
                    .onTapGesture {
                        self.proFile.toggle()
                    }
                Spacer()
                Text("Сервисы")
                    .font(.largeTitle)
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    .bold()
                Image("vk")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 40)
                    .onTapGesture{
                        if UIApplication.shared.canOpenURL(URL(string: "https://vk.com/")!){
                            UIApplication.shared.open(URL(string: "https://vk.com/")!)
                        }
                    }
            }
            .padding(.horizontal, 30)
            .padding(.top, 50)
        }
    }
}

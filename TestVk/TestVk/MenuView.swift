//
//  MenuView.swift
//  TestVk
//
//  Created by Максим Никитин on 7/14/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                MenuRow(title: "Nikitin Maxim", icon: "dog")
                MenuRow(title: "@MaximNikitin08", icon: "telegram-logo")
                MenuRow(title:"nikitinm117@gmail.com", icon: "gmail")
                MenuRow(title:"maximnikitin081102@mail.ru", icon: "mail")
            }
            .frame(maxWidth:.infinity)
            .frame(height: 350)
            .background(Color(UIColor(red: 0.91, green: 0.26, blue: 0.58, alpha: 1.00)))
            .clipShape(RoundedRectangle(cornerRadius: 40, style: .continuous))
            .shadow(radius: 30)
            .padding(.horizontal, 30)
            .overlay(
                Image("me")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .offset(y: -150)
            )
        }
        .padding(.bottom, 30)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct MenuRow: View {
    var title: String
    var icon: String
    var body: some View {
        HStack(spacing:15) {
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            Text(title)
                .font(.system(size: 18, weight: .bold, design: .rounded))
        }
    }
}

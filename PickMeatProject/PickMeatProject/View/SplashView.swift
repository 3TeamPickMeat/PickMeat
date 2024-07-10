//
//  SplashView.swift
//  PickMeatProject
//
//  Created by BEOM SHIEK KANG on 7/3/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack(content: {
                Text("안전한 먹거리의 첫 시작.")
                    .font(.headline)
                    .fontWeight(.light)
                    .foregroundStyle(.secondary)
                    .padding()
                Image("main_logo")
                    .resizable()
                    .frame(width: 300, height: 410)
                    .fixedSize()
                    .padding()
                
            })
        }
    }
}

#Preview {
    SplashView()
}

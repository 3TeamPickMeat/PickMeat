//
//  progres.swift
//  PickMeatProject
//
//  Created by BEOM SHIEK KANG on 7/8/24.
//

import SwiftUI

struct CustomProgressView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ProgressView("로딩중...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black.opacity(0.75))
                    .cornerRadius(10)
            }
        }
    }
}

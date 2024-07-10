//
//  PredictResultView.swift
//  PickMeatProject
//
//  Created by BEOM SHIEK KANG on 7/9/24.
//

import SwiftUI

struct PredictResultView: View {
    
    let resultText: String
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    if resultText == "신선" {
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                    } else if resultText == "평범" {
                        Image(systemName: "exclamationmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "multiply.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)

                    }
                    Text(resultText)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(
                            Color.white.opacity(0.2)
                                .cornerRadius(15)
                        )
                        .padding(.horizontal, 20)
                }
                .padding()
                .background(
                    Color.white.opacity(0.1)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                )
                .padding(.horizontal, 20)
                .transition(.scale)
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .animation(.easeInOut(duration: 0.5), value: resultText)
    }
}

struct PredictResultView_Previews: PreviewProvider {
    static var previews: some View {
        PredictResultView(resultText: "This is a test result.")
    }
}

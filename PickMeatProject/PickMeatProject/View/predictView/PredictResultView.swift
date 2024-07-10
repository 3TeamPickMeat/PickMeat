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
            if resultText.isEmpty{
            
                CustomProgressView()
            } else {
               
                VStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        if resultText.trimmingCharacters(in: CharacterSet(charactersIn: "\"")) == "신선한거같아요" {
                            Image(systemName: "checkmark.seal.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.white)
                        } else if resultText.trimmingCharacters(in: CharacterSet(charactersIn: "\"")) == "평범한 상태에요" {
                            Image(systemName: "exclamationmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.white)
                        } else {
                            
                            Image(systemName: "multiply.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.white)
                                
                        }
                        Text("상했을 가능성이 높아요.")
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
                    NavigationLink(destination: ContentView(), label: {
                              Text("홈으로")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 100, height: 40)
                                .background(Color.purple)
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                            })
                    Spacer()
                }
                .padding(.horizontal, 20)
            }
            
            }.animation(.easeInOut(duration: 0.5), value: resultText)
           
    }
    
}

struct PredictResultView_Previews: PreviewProvider {
    static var previews: some View {
        PredictResultView(resultText: "This is a test result.")
    }
}

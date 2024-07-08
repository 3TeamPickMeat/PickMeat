//
//  TipView.swift
//  PickMeatProject
//
//  Created by BEOM SHIEK KANG on 7/3/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct TipView: View {
    
    @State var selectedMapType = 0
    let imageURL = URL(string: "https://i.ytimg.com/vi/UGlD9DRRuEw/hq720.jpg?sqp=-oaymwEcCNAFEJQDSFXyq4qpAw4IARUAAIhCGAFwAcABBg==&rs=AOn4CLAGb5_DcOTJfNq3BDO-UY57EHsWNQ")
    let linkURL = URL(string: "https://www.youtube.com/watch?v=UGlD9DRRuEw&pp=ygUQ6rOg6riwIOuztOq0gOuylQ%3D%3D")
    var body: some View {
   
        NavigationView(content: {
            VStack(content: {
                Picker(selection: $selectedMapType, label: Text("Select an Option")){
                    Text("보관 요령").tag(0)
                    Text("수입,국산 특징").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .position(x: 175, y: 10)
                    .frame(width: 350)
                    .padding()
                
                    switch selectedMapType{
                    case 0:
                        VStack(content: {
                            Text("돼지고기를 장기간 맛있게 보관하자!")
                            .font(.headline)
                            .padding()
                        HStack(content: {
                            VStack(alignment: .leading,content: {
                                    
                                Text("① 공기에 닿지 않게 한다.")
                                    .padding(.leading,20)
                                Text("② 소분해서 냉동한다.")
                                    .padding(.leading,20)
                                Text("③ 가급적 빨리 섭취하자.")
                                    .padding(.leading,20)
                                })
                            
                                Spacer()
                                })
                        Divider()
                            .frame(height: 60)
                                Text("참고 동영상")
                                    .padding()
                                WebImage(url: imageURL)
                                       .resizable()
                                       .frame(width: 150, height: 130)
                                       .scaledToFit()
                                       .padding()
                                       .onTapGesture {
                                           UIApplication.shared.open(linkURL!)
                                      
                                       }
                          
                                HStack(content: {
                                    Spacer()
                                    Text("출처: 백종원 유튜브")
                                        .padding()
                                })
                            })
                          
                        case 1:
                            VStack(content: {
                                Image("site_logo")
                                    .resizable()
                                    .frame(width: 320, height: 120)
                                    .fixedSize()
                                    //.padding()
                                    .onTapGesture {
                                        UIApplication.shared.open(URL(string: "https://www.naqs.go.kr/main/main.do")!)
                                    }
                                Text("관련 정보보기: 클릭 -> 업무소개 -> 원산지 관리 -> 축산물류")
                                Spacer()
                            })

                        default:
                            Text("내용이 없습니다.")
                        }
                    })
                    .frame(height: 600) // 최소 높이 설정
                    .navigationTitle("꿀팁")
                    .navigationBarTitleDisplayMode(.automatic)
            
        })

      
        }
}

#Preview {
    TipView()
}

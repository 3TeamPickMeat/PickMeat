//
//  ResultDetailView.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/8/24.
//

import SwiftUI

struct ResultDetailView: View {
    
    @State var meatFreshList: [ResultDetailModel] = []
    
    var body: some View {
        NavigationView(content: {
         
            ZStack(content: {
                Color(.black)
                    .ignoresSafeArea()
                if meatFreshList.isEmpty{
                    Text("검사 기록 없음")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.white)
                
                }
                List(content: {
                    ForEach(meatFreshList, id: \.id, content: {meatFresh in

                            HStack(content: {
                                Image(uiImage: meatFresh.meatImage)
                                    .resizable()
                                    .frame(width: 60,height: 60)
                                    .scaledToFit()
                                VStack(alignment: .leading, content: {
                                    Text("고기 신선도 : \(meatFresh.meatFresh)")
                                    Text("날짜 : \(meatFresh.date)")
                                        .font(.system(size: 14))
                                    
                                })
                            })
                    })
                })
                .onAppear(perform: {
                    meatFreshList.removeAll()
                    let resultVm = ResultDetailViewModel()
                    meatFreshList = resultVm.queryDB()
                    
                })
                //.navigationTitle("검사 내역")
                
                .navigationBarTitleDisplayMode(.automatic)
                .toolbar{
                    ToolbarItem( placement: .principal, content: {
                        Text("검사 내역")
                            .foregroundStyle(.white)
                        
                    })
                }
            })
            })
    }
}
#Preview {
    ResultDetailView()
}

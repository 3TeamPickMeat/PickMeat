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
            List(content: {
                ForEach(meatFreshList, id: \.id, content: {meatFresh in
//                    NavigationLink(destination: DetailView(student: student, image: student.image), label: {
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

//                    })
                })
//                .onDelete(perform: { indexSet in
//                    for index in indexSet{
//                        let item = meatFreshList[index]
//                        let resultVm = ResultDetailViewModel()
//                        _ = resultVm.deleteDB(id: Int32(item.id))
//                    }
//                })
            })
            .onAppear(perform: {
                meatFreshList.removeAll()
                let resultVm = ResultDetailViewModel()
                meatFreshList = resultVm.queryDB()
                
            })
            .navigationTitle("검사 내역")
            .navigationBarTitleDisplayMode(.automatic)
        })
    }
}
#Preview {
    ResultDetailView()
}

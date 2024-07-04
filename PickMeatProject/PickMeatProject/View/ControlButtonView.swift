//
//  ControlButtonView.swift
//  PickMeatProject
//
//  Created by 박정민 on 7/4/24.
//

import SwiftUI

struct ControlButtonView: View {
    
    let label: String
    let action: () -> Void
    
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(label)
                .tint(.white)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    ControlButtonView(label: "Cancel", action: {})
}

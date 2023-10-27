//
//  SharePageView.swift
//  train-window-app
//
//  Created by yuuta on 2023/10/26.
//

import SwiftUI

struct SharePageView: View {
    var spvm = SharePageViewModel()
    
    var body: some View {
        VStack{
            Spacer()
            Text("Hello, Share!")
            Spacer()
            Button(action: {
                spvm.getPing()
            }) {
                Text("get-ping")
            }
            Spacer()
            Button(action: {
                spvm.postPing()
            }) {
                Text("post-ping")
            }
            Spacer()
        }
    }
}

struct SharePageView_Previews: PreviewProvider {
    static var previews: some View {
        SharePageView()
    }
}

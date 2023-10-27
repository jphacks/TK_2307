//
//  SharePageViewModel.swift
//  train-window-app
//
//  Created by yuuta on 2023/10/27.
//

import SwiftUI

class SharePageViewModel {
    var sm: SampleModel = SampleModel()
    
    func getPing() {
        sm.getPing()
    }
    
    func postPing() {
        sm.postPing()
    }
}

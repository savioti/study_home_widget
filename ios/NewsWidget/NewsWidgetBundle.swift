//
//  NewsWidgetBundle.swift
//  NewsWidget
//
//  Created by user253537 on 12/17/24.
//

import WidgetKit
import SwiftUI

@main
struct NewsWidgetBundle: WidgetBundle {
    var body: some Widget {
        NewsWidget()
        NewsWidgetLiveActivity()
    }
}

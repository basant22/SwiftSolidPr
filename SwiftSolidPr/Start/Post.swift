//
//  Post.swift
//  TestProj
//
//  Created by Kumar Basant on 09/12/22.
//

import SwiftUI

struct Post:Identifiable {
    var id :Int
    var postImage:String
}

class MyPost:ObservableObject{
    @Published var post:[Post]
    init(post: [Post]) {
        self.post = post
    }
}

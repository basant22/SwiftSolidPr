//
//  Debouncing.swift
//  SwiftSolidPr
//
//  Created by apple on 26/04/26.
//

import Foundation

class Debouncing{
    var interval:TimeInterval!
    var que:DispatchQueue!
    var item:DispatchWorkItem?
    
    init(interval:TimeInterval,que:DispatchQueue){
        self.interval = interval
        self.que = que
    }
    
    func search(work:@escaping()->Void){
        self.item?.cancel()
        let item = DispatchWorkItem(block: work)
        self.item = item
        self.que.asyncAfter(deadline: .now() + interval, execute: item)
    }
    func cancle(){
        self.item?.cancel()
        self.item = nil
    }
}

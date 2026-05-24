//
//  ContentViewModel.swift
//  SwiftSolidPr
//
//  Created by apple on 14/05/26.
//

import Foundation
import Combine

class ContentViewModel:ObservableObject{
    @Published var defaultTmer:Int = 0
    @Published var commonTimer:Int = 0
    @Published var imagedata:Data?
    @Published var isLoading:Bool = false
    private var bag = Set<AnyCancellable>()
    init(){
        initDefaultTimer()
        initNormalTimer()
    }
    func initDefaultTimer(){
        let timer:Timer = Timer.scheduledTimer(timeInterval:
                                                1,
                                               target: self,
                                               selector: #selector(startDefaultTimer),
                                               userInfo: nil,
                                               repeats: true)
        RunLoop.current.add(timer, forMode: .default)
    }
    func initNormalTimer(){
        let timer:Timer = Timer.scheduledTimer(timeInterval:
                                                1,
                                               target: self,
                                               selector: #selector(startCommonTimer),
                                               userInfo: nil,
                                               repeats: true)
        RunLoop.current.add(timer, forMode: .common)
    }
    @objc private func startDefaultTimer(){
        defaultTmer += 1
        if defaultTmer == 5{
            downloadImage()
        }
    }
    @objc private func startCommonTimer(){
        commonTimer += 1
        
    }
    private func downloadImage(){
        isLoading = true
        guard let url = URL(string: "https://picsum.photos/300/600") else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for:url)
            .map{ $0.data }
            .replaceError(with: nil)
            .receive(on:DispatchQueue.main)
            .sink{[weak self] in
                if let data = $0{
                    self?.imagedata = data
                    self?.isLoading = false
                }
            }
            .store(in: &bag)
    }
}

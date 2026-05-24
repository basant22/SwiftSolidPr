//
//  LoadImageViewModel.swift
//  SwiftSolidPr
//
//  Created by apple on 15/05/26.
//

import Foundation
import UIKit
protocol LoadImageViewModelProtocol{
    func loadImage(url:URL)async throws
}
class LoadImageViewModel:ObservableObject,LoadImageViewModelProtocol{
    @Published var image:UIImage = UIImage()
    let objCache:CachedImageProtocol
    init(objCache:CachedImageProtocol){
        self.objCache = objCache
    }
    
    func loadImage(url:URL)async throws{
        do{
            guard let img = try await self.objCache.cachedImage(url: url)else {return}
           self.image = img
        }catch{
            throw error
        }
    }
}
class GalleryViewModel:ObservableObject{
    @Published var downloadImage:[URL:UIImage] = [:]
    @Published var isLoading:[URL:Bool] = [:]
    let objCache:CachedImageProtocol
    init(objCache:CachedImageProtocol){
        self.objCache = objCache
    }
    func loadImage(url:URL)async throws{
        guard downloadImage[url] == nil , isLoading[url] != true else {return}
        isLoading[url] = true
        do{
            guard let img = try await self.objCache.cachedImage(url: url)else {return}
            downloadImage[url] = img
           
        }catch{
            throw error
        }
        isLoading[url] = false
    }
}

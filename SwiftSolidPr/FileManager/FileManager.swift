//
//  FileManager.swift
//  SwiftSolidPr
//
//  Created by apple on 02/05/26.
//

import Foundation

class FileStore{
    private let fileManager = FileManager.default
    
    func saveFile(tempURL:URL,rootDir:String,path:String,fileName:String) throws ->URL{
        let docDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let patientDir = docDir.appendingPathComponent(String(rootDir),isDirectory: true)
        let typeDir = patientDir.appendingPathComponent(String(path),isDirectory: true)
        do{
            try fileManager.createDirectory(at: typeDir, withIntermediateDirectories: true)
            let fileNmae = fileName + ".pdf"
            let destinationURL = typeDir.appendingPathComponent(fileNmae,isDirectory: true)
            if fileManager.fileExists(atPath: destinationURL.path){
                try fileManager.removeItem(at: destinationURL)
            }
            // MOVE
            try fileManager.moveItem(at: tempURL, to: destinationURL)
            return destinationURL
        }catch{
            throw error
        }
    }
}

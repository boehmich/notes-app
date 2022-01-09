//
//  FileManagerService.swift
//  Notes
//
//  Created by Boehmich on 09.01.22.
//  Copyright © 2022 boehmich. All rights reserved.
//

import Foundation

class FileManagerService{

    var directoryPath: [URL] {
        let fileManager = FileManager.default
        return fileManager.urls(for: .documentDirectory, in: .userDomainMask)
    }
    
    
    func getSoundFileUrl(soundFileName: String) -> URL {
        return directoryPath[0].appendingPathComponent("\(soundFileName).caf")
    }
    
    func updateSoundFileUrl(originName: String, newName: String){
        let originPath = directoryPath[0].appendingPathComponent("\(originName).caf")
        let destinationPath = directoryPath[0].appendingPathComponent("\(newName).caf")
        
        do {
            try FileManager.default.moveItem(at: originPath, to: destinationPath)
        } catch {
            print(error)
        }
    }
    
    func deleteSoundFile(fileName: String){
        let path = directoryPath[0].appendingPathComponent("\(fileName).caf")
        
        do {
            try FileManager.default.removeItem(at: path)
        } catch {
            print(error)
        }
    }
    
    
    func isSoundFileUrlAvailable(fileName: String) -> Bool {
        let path = directoryPath[0].appendingPathComponent("\(fileName).caf").path
        
        if(FileManager.default.fileExists(atPath: path)){
            return true
        }
        else{
            return false
        }
    }
    
}

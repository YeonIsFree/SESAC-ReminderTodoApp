//
//  FileManager+.swift
//  SESAC-ReminderTodoApp
//
//  Created by Seryun Chun on 2024/02/20.
//

import UIKit

extension UIViewController {
    func saveImageToDocument(image: UIImage, filename: String) {
        // 앱 내에 있는 도큐먼트 폴더 위치 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                               in: .userDomainMask).first else { return }
        // 도큐먼트 폴더 내에 이미지를 저장할 경로(파일명) 생성
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        // 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        
        // 이미지 파일 저장
        do {
            try data.write(to: fileURL)
        } catch {
            print("file save error", error)
        }
    }
    
    func loadImageFromDocument(filename: String) -> UIImage? {
        // 앱 내에 있는 도큐먼트 폴더 위치 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        // 찾아야할 이미지 경로
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        // 찾아온 경로에 실제 파일이 존재하는지 확인
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path())
        } else { return nil }
    }
    
    func removeImageFromDocument(filename: String) {
        guard let documentDirectory = FileManager.default.urls(for:.documentDirectory,
                                                               in: .userDomainMask).first else { return }
        
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        
        // 폴더 내에 존재한다면
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path())
            } catch {
                print("file remove error", error)
            }
        } else {
            print("file not exist, remove error")
        }
        
    }
}

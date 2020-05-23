//
//  Collection.swift
//  smalltsu
//
//  Created by Kanako Yamashita on 2020/05/09.
//  Copyright © 2020 Kanako Yamashita. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import AVFoundation

class Collection: NSObject {
    
    static var collection = Collection()
    
    var db: Firestore!
    
    var storage = Storage.storage()
    
    var audioPlayer: AVAudioPlayer!
    
    var no: Int
    
    var answer: String
    
    var selection1: String
    
    var selection2: String
    
    var soundUrl: String
    
    var imageUrl: String
    
    var image:UIImage
    
    var example: String
    
    //正答数
    var score: Float
    
    //総回答数
    var count: Float
    
    //var collection_Array:[Dictionary] = []
    
    private override init() {
        self.no = 1
        self.answer = "answer"
        self.selection1 = "selection1"
        self.selection2 = "selection2"
        self.soundUrl = "soundUrl"
        self.imageUrl = "imageUrl"
        self.image = UIImage()
        self.example = "example"
        self.score = 0
        self.count = 0
    }
    
    //Firebaseからデータを取得するメソッド
    func getCollection(){
            print("呼ばれたよ")
        print("self.noは" + String(self.no))
            let settings = FirestoreSettings()

            Firestore.firestore().settings = settings
            db = Firestore.firestore()

            self.db.collection("reading").whereField("no", isEqualTo: self.no).getDocuments() {
                (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents{
                        print("\(document.documentID) => \(document.data())")
                        if let answer = document.data()["answer"] as? String,
                        let selection1 = document.data()["selection1"] as? String,
                        let selection2 = document.data()["selection2"] as? String,
                        let soundUrl = document.data()["soundUrl"] as? String,
                        let imageUrl = document.data()["imageUrl"] as? String,
                        let example = document.data()["example"] as? String{
                            self.answer = answer
                            self.selection1 = selection1
                            self.selection2 = selection2
                            self.soundUrl = soundUrl
                            self.imageUrl = imageUrl
                            self.example = example
                            print(self.answer)
                        }
                    }
                }
            }
        }
    
        //cloudstorageから音声データを取ってくる処理
        func downloadSound(){
            storage = Storage.storage()
            print("soundUrl:" + soundUrl)
            let ref = storage.reference(forURL: self.soundUrl)
            
            // Create a reference to the file you want to download

            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let err = error {
                print("downloadSound：\(err)")
              } else {
                     //<- `try!`を使うとエラーが起こった時に原因がわからないままクラッシュする
                    do {
                        //↓作成した`AVAudioPlayer`はインスタンス変数に保持する
                        self.audioPlayer = try AVAudioPlayer(data: data!)
                        self.audioPlayer?.play()
                        } catch {
                            print(error)
                        }
                    }
                }
            }
    
    
        //cloudstorageから画像データを取ってくる処理
        func downloadImg(){
            storage = Storage.storage()
            print("imageUrl:" + imageUrl)
            let ref = storage.reference(forURL: self.imageUrl)
            
            // Create a reference to the file you want to download

            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
              if let err = error {
                print("DownLoadImg：\(err)")
              } else {
                  //UIImage型でデータが入ってくる→UIImageViewに入れる
                  if let image = UIImage(data: data!) {
                    print("DownLoadImg：\(image)")
                    self.image = image
                  }
                }
            }
        }
    
    
}

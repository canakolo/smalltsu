//
//  CorrectViewController.swift
//  smalltsu
//
//  Created by Kanako Yamashita on 2020/05/03.
//  Copyright © 2020 Kanako Yamashita. All rights reserved.
//

import UIKit
import AVFoundation

class CorrectViewController: UIViewController {
    
    let collection = Collection.collection
    
    var audioPlayer : AVAudioPlayer!
    
    //firebaseから取得したanswerを代入する変数
    
    @IBOutlet var answer: UILabel!
    
    //firebaseから取得したimageを代入する変数
    @IBOutlet var answerImg: UIImageView!
    
    //firebaseから取得したexampleを代入する変数
    @IBOutlet var example: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //firebaseからanwer, image, exampleを取得する
        
        //正解音を流す
        let path = Bundle.main.path(forResource: "collect", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
         
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        }
        catch let err as NSError {
            print("Error sound: \(err)")
        }
        
        //firebaseから取得したデータを表示させる
        print(collection.answer)
        answer.text = collection.answer
        
        print(collection.example)
        example.text = collection.example
        //scoreに１を足す
        collection.score += 1
        print(collection.score)
        //countに１を足す
        collection.count += 1
        print(collection.count)
        
        //画像を表示させる
        collection.downloadImg()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.answerImg.image = Collection.collection.image
            print("画像をセットする処理完了")
        }
        
    }
    

    @IBAction func back(_ sender: Any) {
        
        //問題画面にもどる
        let questionViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        self.present(questionViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func exit(_ sender: Any) {
        //結果画面に遷移する
        let resultViewController = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        self.present(resultViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

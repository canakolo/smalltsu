//
//  ResultViewController.swift
//  smalltsu
//
//  Created by Kanako Yamashita on 2020/05/03.
//  Copyright © 2020 Kanako Yamashita. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    let collection = Collection.collection
    //合計正答数を代入する変数
    @IBOutlet var totalScore: UILabel!
    
    //合計回答数を代入する変数
    @IBOutlet var totalCount: UILabel!
    
    //正答率を代入する変数
    var rate: Float = 0
    
    //正答率に応じたメッセージを表示する変数
    @IBOutlet var msgImg: UIImageView!
    
    //リトライボタン
    @IBOutlet var retry: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // retryボタンを非表示にする
        retry.isHidden = true
        
        //totalScoreに代入する
        totalScore.text = String(Int(collection.score)) + "てん"

        //totalCountに代入する
        totalCount.text = String(Int(collection.count)) + "もんちゅう"
        //正答率を計算する
        rate = (collection.score / collection.count) * 100
        print(rate)
        
        //正答率に応じて異なる画像を表示するif文の処理
        switch rate{
        case 80...100:
            msgImg.image = UIImage(named: "great.png")
        case 70..<80:
            msgImg.image = UIImage(named: "good.png")
        case 50..<70:
            msgImg.image = UIImage(named: "normal.png")
        case 30..<50:
            msgImg.image = UIImage(named: "worse.png")
        case 0..<30:
            msgImg.image = UIImage(named: "worst.png")
        default:
            msgImg.image = UIImage(named: "")
        }
        
        //リトライボタンは、２秒遅れで出現する
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.retry.isHidden = false
        }
    }
    
    
    @IBAction func retry(_ sender: Any) {
        
        let questionViewController = self.storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        self.present(questionViewController, animated: true)
        
        //正答数と総回答数を0にする
        collection.count = 0
        collection.score = 0
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

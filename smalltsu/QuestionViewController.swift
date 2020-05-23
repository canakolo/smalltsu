//
//  QuestionViewController.swift
//  smalltsu
//
//  Created by Kanako Yamashita on 2020/05/03.
//  Copyright © 2020 Kanako Yamashita. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController{
    
    let collection = Collection.collection
    
    @IBOutlet var selection1Button: UIButton!
    //firebaseから取得した選択肢１を代入する変数
   

    @IBOutlet var selection2Button: UIButton!
    //firebaseから取得した選択肢２を代入する変数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //firebaseから取得したデータをそれぞれの変数に代入する
        //今はひとつ前の画面で関数を読み込んでいるけど、時間がかかって早すぎると代入できない
        }
    
    @IBAction func playsound(_ sender: Any) {
        //音声を再生する
        collection.downloadSound()
        print("collection.downloadSoundを呼びました")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.selection1Button.setTitle(Collection.collection.selection1, for: .normal)
            self.selection2Button.setTitle(Collection.collection.selection2, for: .normal)
            if self.selection1Button.isHidden == true && self.selection2Button.isHidden == true{
                self.selection1Button.isHidden = false
                self.selection2Button.isHidden = false
            }
        }
    }
    
    //選択肢１を選択した
    @IBAction func check1(_ sender: Any) {

        //selection1とanswerの値が同じかチェックする
        if collection.selection1 == collection.answer{
            //もし同じだった場合、CorrectController画面に遷移する
            print("答えはあっています")
            let correctViewController = self.storyboard?.instantiateViewController(withIdentifier: "CorrectViewController") as! CorrectViewController
            self.present(correctViewController, animated: true)

        } else{
            //もし違った場合、IncorrectController画面に遷移する
            print("答えは間違っています")
            let incorrectViewController = self.storyboard?.instantiateViewController(withIdentifier: "IncorrectViewController") as! IncorrectViewController
            self.present(incorrectViewController, animated: true, completion: nil)
        }



    }
    //選択肢２を選択した
    @IBAction func check2(_ sender: Any) {

        if collection.selection2 == collection.answer{
            //もし同じだった場合、CorrectController画面に遷移する
            print("答えはあっています")
            let correctViewController = self.storyboard?.instantiateViewController(withIdentifier: "CorrectViewController")as! CorrectViewController
            self.present(correctViewController, animated: true, completion: nil)
        } else{
            //もし違った場合、IncorrectController画面に遷移する
            print("答えは間違っています")
            let incorrectViewController = self.storyboard?.instantiateViewController(withIdentifier: "IncorrectViewController") as! IncorrectViewController
            self.present(incorrectViewController, animated: true, completion: nil)
        }

    }
    
    //次の問題を提示する
    @IBAction func nextQuestion(_ sender: Any) {

        //問題番号を更新する
       collection.no = collection.no + 1
       print("collection.noは、" + String(collection.no))

        //firebaseから新しい問題データを取得する
        //Firebaseからデータを取得した後に、selection1とselection2の値として代入する
            
            var i = 1
//        DispatchQueue(label: "").async {
//                Collection.collection.getCollection()
//            //UI表示系タスクはmainの中で行う
//            DispatchQueue.main.async{
//                    self.selection1Button.setTitle(Collection.collection.selection1, for: .normal)
//                    self.selection2Button.setTitle(Collection.collection.selection2, for: .normal)
//                    i += 1
//                    print("iは" + String(i))
//                }
//            }
        
             DispatchQueue(label: "重い処理").async{
                 Collection.collection.getCollection()
                 DispatchQueue.main.async{
                     self.selection1Button.isHidden = true
                     self.selection2Button.isHidden = true
                     
                     i += 1
                     print("iは、" + String(i))
                }
             }
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

//
//  SelectTypeViewController.swift
//  smalltsu
//
//  Created by Kanako Yamashita on 2020/05/03.
//  Copyright © 2020 Kanako Yamashita. All rights reserved.
//

import UIKit

class SelectTypeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let collection = Collection.collection
        collection.getCollection()
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

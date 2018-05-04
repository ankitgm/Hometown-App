//
//  DetailsVC.swift
//  HometownApp
//
//  Created by Apple on 10/30/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
class DetailsVC: UIViewController {
    //country
    var person: String = ""
    var nickname: String = ""
    var state: String = ""
    var city:String = ""
    var year:Int = 0
    
    
    @IBOutlet weak var state1: UILabel!
    @IBOutlet weak var city1: UILabel!
    @IBOutlet weak var year1: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var country: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        country.text = person
        state1.text = state
        city1.text = city
        name.text = nickname
        year1.text = String(year)
        
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

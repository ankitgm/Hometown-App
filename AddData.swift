//
//  AddData.swift
//  HometownApp
//
//  Created by Apple on 11/1/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

var countryNameFetched:String = ""
var qw1:String?
var qw2:String?
var qw3:String?
var qw4:String?
var qw5:String?
var qw6:String?
var qw7:String = ""
var qw8:String = ""
class AddData:GetLocation, UITextFieldDelegate, UIAlertViewDelegate {
    var cc1:[String] = []
    var cc2:[String] = []
    var lat:Double = 0
    var long:Double = 0
    @IBAction func clearButton(_ sender: UIButton) {
        nickName1.text = ""
        password1.text = ""
        city1.text = ""
        country1.text = ""
        state1.text = ""
        year1.text = ""
        latVal.text = "0.0"
        longVal.text = "0.0"
        
    }
    
    
    
    @IBAction func getLocationPressed(_ sender: Any) {
        
        if(latVal.text! != ""){
            if let latValue = Double(latVal.text!), latValue >= -90, latValue <= 90{
                lat = latValue
            }else{
                ShowAlert(title: "Alert", message: "Latitude value not in the range [-90,90]")
                return
            }
        }
        if(longVal.text! != ""){
            if let longValue = Double(longVal.text!), longValue >= -180, longValue <= 180{
                long = longValue
            }else{
                ShowAlert(title: "Alert", message: "Longitude value not in the range [-180,180]")
                return
            }
        }
        qw1  =   nickName1.text
        qw2   =  city1.text
        qw3   = qw7
        qw4    = qw8
        qw5    = year1.text
        qw6   = password1.text
        performSegue(withIdentifier: "yoyo23", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "yoyo23") {
            let secondController = segue.destination as! GetLocation
            
            secondController.lat1 = latVal.text! != "" ? latVal.text! : "0"
            secondController.lat2 = longVal.text! != "" ? longVal.text! : "0"
            secondController.qw3 = qw3
            secondController.qw4 = qw4
        }
        
    }
    override func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    override func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows: Int = cc1.count
        if pickerView == dropDown1
        {
            countrows = cc2.count
        }
        
        return countrows
    }
    override func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == dropDown {
            let titlerow = cc1[row]
            //print(cc1)
            return titlerow
        }
        else if pickerView == dropDown1
        {
            
            let titlerow = cc2[row]
            //print (titlerow)
            return titlerow
        }
        return ""
    }
    override func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == dropDown{
            countryNameFetched = cc1[row]
            datafetch()
            dropDown1.isHidden = false
            country1.text = cc1[row]
            qw8 = cc1[row]
        }
        else if pickerView == dropDown1 {
            state1.text = cc2[row]
            qw7 = cc2[row]
            
        }
    }
    @IBOutlet weak var nickName1: UITextField!
    @IBOutlet weak var city1: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    //@IBOutlet weak var state1: UITextField!
    @IBOutlet weak var country1: UILabel!
   // @IBOutlet weak var country1: UITextField!
    @IBOutlet weak var state1: UILabel!
    @IBOutlet weak var dropDown1: UIPickerView!
    @IBOutlet weak var year1: UITextField!
    @IBOutlet weak var password1: UITextField!
    @IBOutlet weak var latVal: UITextField!
    @IBOutlet weak var longVal: UITextField!
    @IBOutlet weak var postButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        nickName1.text = qw1
        city1.text = qw2
        state1.text = qw7
        country1.text = qw8
        year1.text = qw5
        password1.text = qw6
        latVal.text = latt
        longVal.text = longg
    }
    func datafetch(){
        guard let url2 = URL (string: "https://bismarck.sdsu.edu/hometown/states?country=\(countryNameFetched)") else {return}
        cc2 = []
        let session1 = URLSession.shared
        session1.dataTask (with: url2) {(data, response, error) in
            if let response = response {
                print (response)
            }
            if let data = data {
               // print (data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    //print (json)
                    
                    guard let array = json as? [Any] else { return }
                    for user in array {
                        
                        guard let userDict = user as? String else {return}
                        
                        self.cc2.append(userDict)
                        //print (self.cc2)
                    }
                    DispatchQueue.main.async {
                        self.dropDown1.reloadAllComponents()
                        self.dropDown1.selectRow(0, inComponent: 0, animated: true)
                        self.state1.text = self.cc2[0]
                        qw7 = self.cc2[0]
                    }
                    
                }
                catch {
                    print(error)
                }
            }
            }.resume()
    }
    override func viewDidLoad() {
        
        dropDown1.isHidden = true
        dropDown.delegate = self
        dropDown1.delegate = self
        dropDown.dataSource = self
        dropDown.dataSource = self
        latVal.text = "0.0"
        longVal.text = "0.0"
        guard let url = URL (string: "https://bismarck.sdsu.edu/hometown/countries") else {return}
        
        let session = URLSession.shared
        session.dataTask (with: url) {(data, response, error) in
            if let response = response {
                print (response)
            }
            
            if let data = data {
                // print (data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    //print (json)
                    
                    guard let array = json as? [Any] else { return }
                    for user in array {
                        
                        guard let userDict = user as? String else {return}
                        
                        self.cc1.append(userDict)
                        //print (self.cc1)
                    }
                    DispatchQueue.main.async {
                        self.dropDown.reloadAllComponents()
                    }
                }
                catch {
                    print(error)
                }
            }
            }.resume()
        //  print (cc1)
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    func ShowAlert(title: String, message: String ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func postButton(_ sender: UIButton) {
        
        
        let pwd = password1.text!
        let nname = nickName1.text!
        var lat = 0.0
        
        
        //        lat  = latVal.text! != "" ? Double (latVal.text!)! : 0.0
        var long = 0.0
        //        long = latVal.text! != "" ? Double (longVal.text!)! : 0.0
        if nickName1.text == ""
        {ShowAlert(title: "Alert", message: "Nickname cannot be null")
            return
        }
        let url1 = URL (string: "https://bismarck.sdsu.edu/hometown/nicknameexists?name=\(nname)")
        
        let session1 = URLSession.shared
        session1.dataTask (with: url1!) {(data, response, error) in
            if let response = response {
                print (response)
            }
            
            if let data = data {
                print (data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if (json as! Bool == true)
                    {
                        self.ShowAlert(title: "Alert", message: "Nickname not Unique")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self.tableViiew.reloadData()
                        
                    }
                }
                catch {
                    print(error)
                }
                
            }
            
            }.resume()
        
        
        if city1.text == ""
        {ShowAlert(title: "Alert", message: "City cannot be null")
            return
        }
        if country1.text == ""
        {ShowAlert(title: "Alert", message: "Country cannot be null")
            return
        }
        if state1.text == ""
        {ShowAlert(title: "Alert", message: "State cannot be null")
            return
        }
        if year1.text == ""
        {ShowAlert(title: "Alert", message: "Year cannot be null")
            return
        }
        
        if pwd.count <= 2
        {
            ShowAlert(title: "Alert", message: "Password length should be more than or equal to 3")
            return
        }
        
        let d = nickName1.text?.uppercased()
        let capitalizedArray = nikki4.map { $0.uppercased()}
        for i in capitalizedArray
        {
            if d==i
            {
                ShowAlert(title: "Alert", message: "Nickname not unique")
                return
            }
        }
        if(latVal.text! != ""){
            if let latValue = Double(latVal.text!), latValue >= -90, latValue <= 90{
                lat = latValue
            }else{
                ShowAlert(title: "Alert", message: "Latitude value not in the range [-90,90]")
                return
            }
        }
        if(longVal.text! != ""){
            if let longValue = Double(longVal.text!), longValue >= -180, longValue <= 180{
                long = longValue
            }else{
                ShowAlert(title: "Alert", message: "Longitude value not in the range [-180,180]")
                return
            }
        }
        
        
        if let yearValue = Double(year1.text!), yearValue >= 1970, yearValue <= 2017{}
        else
        {
            ShowAlert(title: "Alert", message: "Year should be between 1970 to 2017")
            return
            
        }
        let parameters = ["nickname":nickName1.text!,"password":pwd, "city":city1.text!,"longitude": long,"state":state1.text!,"year":Int(year1.text!)!,"latitude":lat,"country":country1.text!] as [String : Any]
        print(parameters)
        guard let url = URL(string: "https://bismarck.sdsu.edu/hometown/adduser") else {return}
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {return}
        request.httpBody = httpBody
        let session = URLSession.shared
        session.dataTask(with: request){(data, response, error) in
            if let response = response {
                print (response)
            }
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print (json)
                    
                }
                catch{
                    print(error)
                }
            }
            }.resume()
        ShowAlert(title: "Success", message: "Data posted")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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


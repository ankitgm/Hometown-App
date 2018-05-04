//
//  ViewController.swift
//  HometownApp
//
//  Created by Apple on 10/30/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

var countrystr:[String] = []
var namename:[String] = []
var citycity:[String] = []
var yearyear:[Int] = []
var latlat:[Double] = []
var longlong:[Double] = []
var yoyo:[Any] = []
var hihi0:String = ""
var hihi:String = ""
var hihi1:String = ""
var hihi2:String = ""
var hihi3:Int = 0
var hihi4:Double = 0.0
var hihi5:Double = 0.0
var i = 0
var yeer = Array(1970...2017)
var nikki:[String] = []
var nikki4:[String] = []
var count = 0
var countrryy:[String] = []

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIPickerViewDataSource,UIPickerViewDelegate  {
    @IBAction func showHide(_ sender: UIButton) {
        picky1.isHidden = false
        picky2.isHidden = false
        goPressed.isHidden = false
    }

    
    var yeer1 = yeer.map
    {
        String($0)
    }
    
    var selectedCountry = ""
    var selectedYear = ""
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows: Int = countrryy.count
        if pickerView == picky2
        {
            countrows = yeer1.count
        }
        
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == picky1 {
            
            let titlerow = countrryy[row]
            
            //return row == 0 ? "" : countrryy[row - 1]
            
            
            //print(cc1)
            return titlerow
        }
        else if pickerView == picky2
        {
            
            let titlerow = yeer1[row]
            
            //return row == 0 ? "" : String(yeer[row - 1])
            //print (titlerow)
            return titlerow
        }
        
        return ""
        
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picky1{
            selectedCountry = countrryy[row]
           
            //print (selectedCountry)
        }
        else if pickerView == picky2 {
            selectedYear = (yeer1[row])
            //print(selectedYear)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        hihi0 = nikki[indexPath.row]
        hihi = countrystr[indexPath.row]
        hihi1 = namename[indexPath.row]
        hihi2 = citycity[indexPath.row]
        hihi3 = yearyear[indexPath.row]
        hihi4 = latlat[indexPath.row]
        hihi5 = latlat[indexPath.row]
        performSegue(withIdentifier: "segueID", sender: countrystr[indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nikki.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = nikki[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "segueID",
            
            let detailsVC = segue.destination as? DetailsVC
            
            //let person = sender as? AnyObject as? nikki
            else { return }
        detailsVC.person = hihi
        detailsVC.state = hihi2
        detailsVC.city = hihi1
        detailsVC.nickname = hihi0
        detailsVC.year = hihi3
        
        
    }
    
    @IBOutlet weak var goPressed: UIButton!
    
    @IBOutlet weak var picky1: UIPickerView!
    @IBOutlet weak var picky2: UIPickerView!
    @IBAction func filter(_ sender: Any) {
        nikki=[]
        yoyo = []
        countrystr = []
        namename = []
        citycity = []
        yearyear = []
        latlat = []
        longlong = []
        let url:URL?
        //        var strsel = selectedYear! != "" ? selectedYear! : 0
        if selectedCountry == "" && selectedYear == ""
        {
            
            url = URL (string: "https://bismarck.sdsu.edu/hometown/users")
        }
        else if selectedCountry != "" && selectedYear == ""
        {
            
            url = URL (string: "https://bismarck.sdsu.edu/hometown/users?country=\(selectedCountry)")
        }
        else if selectedYear != "" && selectedCountry == "" {
            url = URL (string: "https://bismarck.sdsu.edu/hometown/users?year=\(selectedYear)")
        }
        else {
            url = URL (string: "https://bismarck.sdsu.edu/hometown/users?year=\(selectedYear)&country=\(selectedCountry)")
        }
        let session = URLSession.shared
        session.dataTask (with: url!) {(data, response, error) in
            if let response = response {
                print (response)
            }
            
            if let data = data {
                print (data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    //print (json)
                    
                    guard let array = json as? [Any] else { return }
                    
                    for user in array {
                        
                        guard let userDict = user as? [String:Any] else {return}
                        //print (userDict)
                        yoyo.append(userDict)
                        //print (yoyo)
                        guard let nickname = userDict["nickname"] as? String else {return}
                        nikki.append(nickname)
                        guard let country = userDict["country"] as? String else {return}
                        countrystr.append(country)
                        guard let state = userDict["state"] as? String else {return}
                        namename.append(state)
                        guard let city = userDict["city"] as? String else {return}
                        citycity.append(city)
                        guard let year = userDict["year"] as? Int else {return}
                        yearyear.append(year)
                        guard let lat = userDict["latitude"] as? Double else {return}
                        latlat.append(lat)
                        guard let long = userDict["longitude"] as? Double else {return}
                        longlong.append(long)
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
    }
    @IBOutlet weak var tableViiew: UITableView!
    
    
    override func viewDidLoad() {
        self.yeer1.insert("", at:0)
        picky1.isHidden = true
        picky2.isHidden = true
        goPressed.isHidden = true
        count += 1
        if count == 1 {
            
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
                            // print (userDict)
                            countrryy.append(userDict)
                        }
                        if self.picky1 != nil{
                            DispatchQueue.main.async {
                                countrryy.insert("", at: 0)
                                self.picky1.reloadAllComponents()
                                self.picky2.reloadAllComponents()
                            }
                        }
                    }
                    catch {
                        print(error)
                    }
                }
                }.resume()
        
        
        
        guard let url1 = URL (string: "https://bismarck.sdsu.edu/hometown/users") else {return}
        
        nikki=[]
        yoyo = []
        countrystr = []
        namename = []
        citycity = []
        yearyear = []
        latlat = []
        longlong = []
        
        
        let session1 = URLSession.shared
        session1.dataTask (with: url1) {(data, response, error) in
            if let response = response {
                print (response)
            }
            
            if let data = data {
                print (data)
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print (json)
                    
                    guard let array = json as? [Any] else { return }
                    
                    for user in array {
                        
                        guard let userDict = user as? [String:Any] else {return}
                        print (userDict)
                        yoyo.append(userDict)
                        //print (yoyo)
                        guard let nickname = userDict["nickname"] as? String else {return}
                        nikki.append(nickname)
                        nikki4.append(nickname)
                        //i += 1
                        guard let country = userDict["country"] as? String else {return}
                        countrystr.append(country)
                        guard let state = userDict["state"] as? String else {return}
                        namename.append(state)
                        guard let city = userDict["city"] as? String else {return}
                        citycity.append(city)
                        guard let year = userDict["year"] as? Int else {return}
                        yearyear.append(year)
                        guard let lat = userDict["latitude"] as? Double else {return}
                        latlat.append(lat)
                        guard let long = userDict["longitude"] as? Double else {return}
                        longlong.append(long)
                        
                    }
                    if self.tableViiew != nil{
                        DispatchQueue.main.async {
                            self.tableViiew.reloadData()
                        }
                    }
                }
                catch {
                    print(error)
                }
            }
            
            }.resume()
        }
    
    }
}

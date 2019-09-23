//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Hasan Ali on 16.09.2019.
//  Copyright © 2019 Hasan Ali Şişeci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var gbpLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func getRatesClicked(_ sender: Any) {
        
        
        
        dateLabel.text =  DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.long)
        
        // 1) Request & Session
        // 2) Response & Data
        // 3) Parsing & JSON Serialization
        
        
        //1
        let url = URL(string: "http://data.fixer.io/api/latest?access_key=1306e668a32426ddc4484188caffbd71")
        
        let session = URLSession.shared
        
        // Closure
        let task = session.dataTask(with: url!) { (data, response , error) in
            if error != nil {
                let alert = UIAlertController(title: "Error!", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            } else {
                //2
                if data != nil {
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        
                        // ASYNC
                        DispatchQueue.main.async {
                            
                            
                            
                            self.baseLabel.text = "Base : " + ((jsonResponse["base"] as? String)!)
                            
                            if let rates = jsonResponse["rates"] as? [String: Any] {
                                
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = "Dolar = " + String(usd) + "$"
                                }
                                if let eur = rates["EUR"] as? Double {
                                    self.eurLabel.text = "Euro = " + String(eur) + "€"
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbpLabel.text = "Pound = " + String(gbp) + "£"
                                }
                                if let jpy = rates["BTC"] as? Double {
                                    self.jpyLabel.text = "Bitcoin = " + String(jpy) + "₿"
                                }
                                if let trk = rates["TRY"] as? Double {
                                    self.tryLabel.text = "Türk Lirası= " + String(trk) + "₺"
                                }
                            }
                        }

                    } catch {
                        print("error")
                    }
                    
                }
            }
        }
        task.resume()
    }
    
}


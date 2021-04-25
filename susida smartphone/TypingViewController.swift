//
//  TypingViewController.swift
//  susida smartphone
//
//  Created by 中村太紀 on 2020/06/12.
//  Copyright © 2020 中村太紀. All rights reserved.
//

import UIKit

class TypingViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var typingtext: UITextField!
    @IBOutlet var kotobalabel: UILabel!
    @IBOutlet var timerlabel: UILabel!
    var count: Float = 0.0
    var timer: Timer = Timer()
    
    
    @IBOutlet var imageView: UIImageView!
    
    let kotobaArray :[String] = ["まんじ","ジョルノ","はい","イエス","水産業"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        typingtext.delegate = self
        // Do any additional setup after loading the view.
        let toolbar = UIToolbar()
        let okButton: UIBarButtonItem = UIBarButtonItem(title: "OK", style: UIBarButtonItem.Style.plain, target: self, action: #selector(tapOkButton(_:)))
        
        toolbar.setItems([okButton], animated: true)
        toolbar.sizeToFit()
        
        typingtext.inputAccessoryView = toolbar
        
        question()
    }
    func question(){
        let kotobaIndex = Int.random(in: 0...4)
        kotobalabel.text = kotobaArray[kotobaIndex]
    }
    
    @objc func up() {
        count = count + 0.01
        timerlabel.text = String(format:"%.2f",count)
    }
    
    @objc func tapOkButton(_ sender: UIButton){
        // キーボードを閉じる
        self.view.endEditing(true)
        
    }
    @IBAction func random(){
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.imageView.isHidden = false
        
        
        if textField.text == kotobalabel.text{
            
            imageView.image = UIImage(named:"icon_139-1-2.png")
            timer .invalidate()
            
            count = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.question()
                self.imageView.isHidden = true
            }
        }else{
            imageView.image = UIImage(named:"icon_140.png")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                self.imageView.isHidden = true
            }
            /*
             // MARK: - Navigation
             
             // In a storyboard-based application, you will often want to do a little preparation before navigation
             override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new！教えて view controller using segue.destination.
             // Pass the selected object to the new view controller.
             }
             */
            
            
        }
        
        
        
        return false
        
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !timer.isValid {
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector:  #selector(self.up), userInfo: nil, repeats: true)
        }
        return true
    }
}


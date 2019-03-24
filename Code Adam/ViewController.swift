//
//  ViewController.swift
//  Code Adam
//
//  Created by 刘祥 on 3/22/19.
//  Copyright © 2019 xiangliu90. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.imageView?.contentMode = .scaleToFill
        // Do any additional setup after loading the view, typically from a nib.
        
//        if let url = URL(string: "https://fcm.googleapis.com/fcm/send"){
//            var request = URLRequest(url: url)
//            request.allHTTPHeaderFields = ["Content-Type":"application/json","Authorization":"key=AAAAcMPHcSo:APA91bFkP8nvLvB3D463wjPeFc0bGFbpo9RAVth42QIG6vmud33I1QW1IWaVmBVthxocXyr659fiaxYf-QXVh4rNFHY_DqzY0KtukBPdNn7SIDvQLUsI-8L8_y0d4gEuT848equl0EM7"]
//            request.httpMethod = "POST"
//            request.httpBody = "{\"to\":\"eR9gKznJfYY:APA91bHExdKVoLmfwOusDhDP8bK4vIYtPNmaVoNy2qU9dIjMcWJjRFvCZiahx-2IAlFCefH2QTGu-wIFe8fBX1xfQfmcj11Wv96baaFfSIm9JUCdcWgidWIxHHVcSbb47ggQh1Whnf1G\",\"notification\":{\"title\":\"this is from http\"}}".data(using: .utf8)
//            URLSession.shared.dataTask(with: request) { (data, urlresponse, error) in
//                if error != nil{
//                    print(error!)
//                }
//            }.resume()
//        }
    }


}


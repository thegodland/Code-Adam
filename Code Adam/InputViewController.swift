//
//  InputViewController.swift
//  Code Adam
//
//  Created by 刘祥 on 3/22/19.
//  Copyright © 2019 xiangliu90. All rights reserved.
//

import UIKit

class InputViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var ageTextfield: UITextField!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var hatTextfield: UITextField!
    @IBOutlet weak var hatColorTextfield: UITextField!
    @IBOutlet weak var upbodyTextfield: UITextField!
    @IBOutlet weak var upbodyColorTextfield: UITextField!
    @IBOutlet weak var lowbodyTextfield: UITextField!
    @IBOutlet weak var lowbodyColorTextfield: UITextField!
    @IBOutlet weak var shoesTextfield: UITextField!
    @IBOutlet weak var shoesColorTextfield: UITextField!
    @IBOutlet weak var faceImgButton: UIButton!
    @IBOutlet weak var upbodyImg: UIImageView!
    @IBOutlet weak var lowbodyImage: UIImageView!
    @IBOutlet weak var shoesImg: UIImageView!
    @IBOutlet weak var hatImg: UIImageView!
    @IBOutlet weak var genderControl: UISegmentedControl!
    
    var gender = "Boy"
    
    let imagePicker = UIImagePickerController()
    var hatPickerView : UIPickerView!
    var hatColorPickerView : UIPickerView!
    var clothesPickerView : UIPickerView!
    var clothesColorPickerView : UIPickerView!
    var pantsPickerView : UIPickerView!
    var pantsColorPickerView : UIPickerView!
    var shoesPickerView : UIPickerView!
    var shoesColorPickerView : UIPickerView!
    
    let hatData = ["None","Cap","Hat"]
    let colorData = ["black","blue","red","yellow"]
    let upClothesData = ["Shirt","Coat","Jacket"]
    let lowClothesData = ["Shorts","Dress","Pants"]
    let shoesData = ["Sports","Sandals","Boots"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        faceImgButton.imageView?.contentMode = .scaleAspectFit
        
        imagePicker.delegate=self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        hatTextfield.delegate = self
        hatColorTextfield.delegate = self
        upbodyTextfield.delegate = self
        upbodyColorTextfield.delegate = self
        lowbodyTextfield.delegate = self
        lowbodyColorTextfield.delegate = self
        shoesTextfield.delegate = self
        shoesColorTextfield.delegate = self
        
    }
    
    
    @IBAction func genderChanged(_ sender: UISegmentedControl) {
        if genderControl.selectedSegmentIndex == 0{
            gender = "Boy"
        }else if genderControl.selectedSegmentIndex == 1{
            gender = "Girl"
        }
    }
    
    
    
    @IBAction func faceBtnTapped(_ sender: UIButton) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    // MARK -- SEND notification
    @IBAction func sendMessageBtnTapped(_ sender: UIButton) {
        
        var bodyContent = "A Missing"
        guard let age = ageTextfield.text else {return}
        if age == ""{
            
        }else{
            bodyContent += " \(age) years old"
        }
       
        bodyContent += " \(gender)"
        
        guard let loc = locationTextfield.text else {return}
        if loc != ""{
            bodyContent += " at \(loc)"
        }

        guard let hat = hatTextfield.text else {return}
        guard let color = hatColorTextfield.text else{return}
        if color != "" && hat != ""{
            bodyContent += " Head: \(color) \(hat),"
        }
  
        guard let upbody = upbodyTextfield.text else{return}
        guard let upbodycolor = upbodyColorTextfield.text else{return}
        if upbodycolor != "" && upbody != ""{
            bodyContent += " Top: \(upbodycolor) \(upbody),"
            
        }
        
            guard let low = lowbodyTextfield.text else{return}
            guard let lowcolor = lowbodyColorTextfield.text else{return}
            if low != "" && lowcolor != ""{
                 bodyContent += " Bottom: \(color) \(low),"
            }
            
            
        
        guard let shoes = shoesTextfield.text else {return}
        
        guard let shoescolor = shoesColorTextfield.text else{return}
        if shoescolor != "" && shoes != ""{
              bodyContent += " Shoes: \(color) \(shoes)."
        }
        

        // prepare json data
        let json: [String: Any] = ["to": "eR9gKznJfYY:APA91bHExdKVoLmfwOusDhDP8bK4vIYtPNmaVoNy2qU9dIjMcWJjRFvCZiahx-2IAlFCefH2QTGu-wIFe8fBX1xfQfmcj11Wv96baaFfSIm9JUCdcWgidWIxHHVcSbb47ggQh1Whnf1G","notification": ["title":"Emergency: Missing Child", "body":"\(bodyContent)"],"data":["hat":hat,"hatcolor":color,"age":age,"gender":gender,"shoes":shoes,"shoescolor":shoescolor,"up":upbody,"upcolor":upbodycolor,"low":low,"lowcolor":lowcolor]]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        if let url = URL(string: "https://fcm.googleapis.com/fcm/send"){
            var request = URLRequest(url: url)
            request.allHTTPHeaderFields = ["Content-Type":"application/json","Authorization":"key=AAAAcMPHcSo:APA91bFkP8nvLvB3D463wjPeFc0bGFbpo9RAVth42QIG6vmud33I1QW1IWaVmBVthxocXyr659fiaxYf-QXVh4rNFHY_DqzY0KtukBPdNn7SIDvQLUsI-8L8_y0d4gEuT848equl0EM7"]
            request.httpMethod = "POST"
            request.httpBody = jsonData
            URLSession.shared.dataTask(with: request) { (data, urlresponse, error) in
                if error != nil{
                    print("!!!!!!!there is a error about that \(error!)")
                }
                }.resume()
        }
        
    }
    
    // MARK - TextField Delegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag{
        case 0: pickUp(hatTextfield)
        case 1: pickUp(hatColorTextfield)
        case 2: pickUp(upbodyTextfield)
        case 3: pickUp(upbodyColorTextfield)
        case 4: pickUp(lowbodyTextfield)
        case 5: pickUp(lowbodyColorTextfield)
        case 6: pickUp(shoesTextfield)
        case 7: pickUp(shoesColorTextfield)
        default:
            print("this should not happed")
            return
        }
    }

}



// MARK -- face image input image view picker delegation
extension InputViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // MARK - DELEGATE FOR IMAGE PICKER
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[.editedImage] as? UIImage{
            faceImgButton.setImage(pickedImage, for: .normal)
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
}


extension InputViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    // MARK - FUNCTION TO CREATE UIPickerView with ToolBar
    func pickUp(_ textField : UITextField){
        
        let tagID = textField.tag
        switch tagID{
        case 0:
            hatPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
            hatPickerView.delegate = self
            hatPickerView.dataSource = self
            hatPickerView.backgroundColor = UIColor.white
            hatTextfield.inputView = hatPickerView
        case 1:
            hatColorPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
            hatColorPickerView.delegate = self
            hatColorPickerView.dataSource = self
            hatColorPickerView.backgroundColor = UIColor.white
            hatColorTextfield.inputView = hatColorPickerView
        case 2:
            clothesPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
            clothesPickerView.delegate = self
            clothesPickerView.dataSource = self
            clothesPickerView.backgroundColor = UIColor.white
            upbodyTextfield.inputView = clothesPickerView
        case 3:
            clothesColorPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
            clothesColorPickerView.delegate = self
            clothesColorPickerView.dataSource = self
            clothesColorPickerView.backgroundColor = UIColor.white
            upbodyColorTextfield.inputView = clothesColorPickerView
        case 4:
            pantsPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
            pantsPickerView.delegate = self
            pantsPickerView.dataSource = self
            pantsPickerView.backgroundColor = UIColor.white
            lowbodyTextfield.inputView = pantsPickerView
        case 5:
            pantsColorPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
            pantsColorPickerView.delegate = self
            pantsColorPickerView.dataSource = self
            pantsColorPickerView.backgroundColor = UIColor.white
            lowbodyColorTextfield.inputView = pantsColorPickerView
        case 6:
            shoesPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
            shoesPickerView.delegate = self
            shoesPickerView.dataSource = self
            shoesPickerView.backgroundColor = UIColor.white
            shoesTextfield.inputView = shoesPickerView
        case 7:
            shoesColorPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
            shoesColorPickerView.delegate = self
            shoesColorPickerView.dataSource = self
            shoesColorPickerView.backgroundColor = UIColor.white
            shoesColorTextfield.inputView = shoesColorPickerView
        default:print("this should not happen");return
        }
    
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
        
    }
    
    // MARK - DATA SOURCE METHOD OF PICKERVIEW
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == hatPickerView{
            return hatData.count
        }else if pickerView == clothesPickerView{
            return upClothesData.count
        }else if pickerView == pantsPickerView{
            return lowClothesData.count
        }else if pickerView == shoesPickerView{
            return shoesData.count
        }else{
            return colorData.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == hatPickerView{
            return hatData[row]
        }else if pickerView == clothesPickerView{
            return upClothesData[row]
        }else if pickerView == pantsPickerView{
            return lowClothesData[row]
        }else if pickerView == shoesPickerView{
            return shoesData[row]
        }else{
            return colorData[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == hatPickerView{
            hatTextfield.text = hatData[row]
            hatImg.image = UIImage(named: hatData[row].lowercased())
            hatImg.contentMode = .scaleAspectFill
        }else if pickerView == clothesPickerView{
            upbodyTextfield.text = upClothesData[row]
            upbodyImg.image = UIImage(named: upClothesData[row].lowercased())
            upbodyImg.contentMode = .scaleAspectFill
        }else if pickerView == pantsPickerView{
            lowbodyTextfield.text = lowClothesData[row]
            lowbodyImage.image = UIImage(named: lowClothesData[row].lowercased())
            lowbodyImage.contentMode = .scaleAspectFill
        }else if pickerView == shoesPickerView{
            shoesTextfield.text = shoesData[row]
            shoesImg.image = UIImage(named: shoesData[row].lowercased())
            shoesImg.contentMode = .scaleAspectFill
        }else if pickerView == hatColorPickerView{
            hatColorTextfield.text = colorData[row]
            hatImg.backgroundColor = UIColor(named: colorData[row].lowercased())
        }else if pickerView == clothesColorPickerView{
            upbodyColorTextfield.text = colorData[row]
            upbodyImg.backgroundColor = UIColor(named: colorData[row].lowercased())
    
        }else if pickerView == pantsColorPickerView{
            lowbodyColorTextfield.text = colorData[row]
            lowbodyImage.backgroundColor = UIColor(named: colorData[row].lowercased())
   
        }else{
            shoesColorTextfield.text = colorData[row]
            shoesImg.backgroundColor = UIColor(named: colorData[row].lowercased())

        }
    }
    // - MARK - FUNCTIONS FOR TOOLBAR BUTTON
    @objc func doneClick(textField: UITextField) {
        self.view.endEditing(true)
    }
    @objc func cancelClick(textField: UITextField) {
        self.view.endEditing(true)
    }
    
}

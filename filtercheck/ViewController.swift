//
//  ViewController.swift
//  filtercheck
//
//  Created by 土屋絢大 on 2017/07/08.
//  Copyright © 2017年 Mr.TUTTY. All rights reserved.
//

import UIKit
import Accounts

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet var cameraImageView: UIImageView!
    var originalimage: UIImage!
    var counter : Int = 0
    @IBOutlet var red: UIButton!
    @IBOutlet var green: UIButton!
    @IBOutlet var blue: UIButton!
    @IBOutlet var greencounter: UILabel!
    @IBOutlet var redcounter: UILabel!
    @IBOutlet var bluecounter: UILabel!
    @IBOutlet var green2: UIButton!
    @IBOutlet var red2: UIButton!
    @IBOutlet var blue2: UIButton!
    @IBOutlet var greenlabel: UILabel!
    @IBOutlet var redlabel: UILabel!
    @IBOutlet var bluelabel: UILabel!
    //hiddenimageview2: UIImageView! ->RGBView:UIView!
    @IBOutlet var RGBView: UIView!
    //hiddenimageView: UIImageView! ->saidoView:UIView!
    @IBOutlet var saidoView:UIView!
    @IBOutlet var hiddenbutton1: UIButton!
    @IBOutlet var hiddenbutton2: UIButton!
    var filter : CIFilter!
    @IBOutlet var hiddenlabel1: UILabel!
    @IBOutlet var filtersetei: UIButton!
    
    var count : Int = 0
    var redcount : Float = 1.0
    var bluecount : Float = 1.0
    var greencount : Float = 1.0
    var count3 : Int = 0
    @IBOutlet var button: UILabel!
    var mozaikcount :Int = 20
    var mozaikcount2 :Int = 50
      override func viewDidLoad() {
        super.viewDidLoad()
       
        saidoView.isHidden = true
        hiddenbutton1.isHidden = true
        hiddenbutton2.isHidden = true
        hiddenlabel1.isHidden = true
        filtersetei.isHidden = true
        green.isHidden = true
        red.isHidden = true
        blue.isHidden = true
        greenlabel.isHidden = true
        redlabel.isHidden = true
        bluelabel.isHidden = true
        greencounter.isHidden = true
        redcounter.isHidden = true
        bluecounter.isHidden = true
        green2.isHidden = true
        red2.isHidden = true
        blue2.isHidden = true
        RGBView.isHidden = true
 
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            cameraImageView.image = image
        } else{
            print("err")
        }
        originalimage = cameraImageView.image
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func susumu() {
     count = count + 1
        if count >= 11{
          count = 0
          button.text = "彩度調節"
          filtersetei.isHidden = true
        }else if count == 0 {
            button.text = "彩度調節"
          filtersetei.isHidden = true
       
        }else if count == 1 {
            button.text = "モザイク弱"
            filtersetei.isHidden = false
        
        }else if count == 2{
            button.text = "モザイク強"
            filtersetei.isHidden = false
           
        }else if count == 3{
            button.text = "色反転"
            filtersetei.isHidden = true
          
        }else if count == 4{
            button.text = "白黒"
            filtersetei.isHidden = true
            
        }else if count == 5{
            button.text = "セピア"
            filtersetei.isHidden = true
           
        }else if count == 6{
            button.text = "古写真"
            filtersetei.isHidden = true
                  }else if count == 7{
            button.text = "偽カラー"
            filtersetei.isHidden = true
            
        }else if count == 8{
            button.text = "ぼかし（円盤）"
        }else if count == 9{
            button.text = "モノカラー"
            filtersetei.isHidden = false
       
        }else if count == 10{
            button.text = "水晶フィルター"
            filtersetei.isHidden = true
        }
    }
    @IBAction func modoru() {
        count = count - 1
        if count <= -1{
            count = 10
            button.text = "水晶フィルター"
            filtersetei.isHidden = true
        }else if count == 0 {
            button.text = "彩度調節"
            filtersetei.isHidden = true
           
        }else if count == 1 {
            button.text = "モザイク弱"
            filtersetei.isHidden = false
        
        }else if count == 2{
            button.text = "モザイク強"
            filtersetei.isHidden = false
      
        }else if count == 3{
            button.text = "色反転"
            filtersetei.isHidden = true
 
        }else if count == 4{
            button.text = "白黒"
            filtersetei.isHidden = true
  
        }else if count == 5{
            button.text = "セピア"
            filtersetei.isHidden = true

        }else if count == 6{
            button.text = "古写真"
            filtersetei.isHidden = true
        }else if count == 7{
            button.text = "偽カラー"
            filtersetei.isHidden = true
        }else if count == 8{
            button.text = "ぼかし（円盤）"
            filtersetei.isHidden = true
        }else if count == 9{
            button.text = "モノカラー"
            filtersetei.isHidden = false
          }else if count == 10{
            button.text = "水晶フィルター"
            filtersetei.isHidden = true
                   }

    }
    @IBAction func savePhoto() {
        UIImageWriteToSavedPhotosAlbum(cameraImageView.image!, nil, nil, nil)
    }
    @IBAction func openAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            counter = counter + 1
            let picker: UIImagePickerController =  UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.delegate = self
            picker.allowsEditing = true
            
            present(picker, animated: true, completion:nil)
        }
    }
    func colorFilter() {
        let filterimage: CIImage = CIImage(image: originalimage)!
        
        filter = CIFilter(name :"CIColorControls")!
        filter.setValue(filterimage, forKey: kCIInputImageKey)
        //彩度の調整
        filter.setValue(1.0, forKey: "inputSaturation")
        filter.setValue(0.5, forKey: "inputBrightness")
        filter.setValue(2.5, forKey: "inputContrast")
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from: filter.outputImage!.extent)
        cameraImageView.image = UIImage(cgImage : cgImage!)
    }
    func mozaikFilter() {
        let filterimage2: CIImage = CIImage(image: originalimage)!
        let filter = CIFilter(name: "CIPixellate")
        // setValueで対象の画像、効果を指定する
        filter?.setValue(filterimage2, forKey: kCIInputImageKey) // フィルタをかける対象の写真
        filter?.setValue(mozaikcount, forKey: "inputScale")          // ブロックの大きさ
        // フィルタ処理のオブジェクト
        let filteredImage:CIImage = (filter?.outputImage)!
        // 矩形情報をセットしてレンダリング
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        cameraImageView.image = outputImage
    }
    func Filter3() {
        let filterimage3: CIImage = CIImage(image: originalimage)!
        let filter = CIFilter(name: "CIPixellate")
        // setValueで対象の画像、効果を指定する
        filter?.setValue(filterimage3, forKey: kCIInputImageKey) // フィルタをかける対象の写真
         filter?.setValue(mozaikcount2, forKey: "inputScale")
        // フィルタ処理のオブジェクト
        let filteredImage:CIImage = (filter?.outputImage)!
        // 矩形情報をセットしてレンダリング
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        cameraImageView.image = outputImage
    }
    func Filter4() {
        let filterimage3: CIImage = CIImage(image: originalimage)!
        let filter = CIFilter(name: "CIColorInvert")
        // setValueで対象の画像、効果を指定する
        filter?.setValue(filterimage3, forKey: kCIInputImageKey) // フィルタをかける対象の写真
        // フィルタ処理のオブジェクト
        let filteredImage:CIImage = (filter?.outputImage)!
        // 矩形情報をセットしてレンダリング
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        cameraImageView.image = outputImage
    }
    func Filter5() {
        let filterimage3: CIImage = CIImage(image: originalimage)!
        let filter = CIFilter(name: "CIPhotoEffectMono")
        // setValueで対象の画像、効果を指定する
        filter?.setValue(filterimage3, forKey: kCIInputImageKey) // フィルタをかける対象の写真
        // フィルタ処理のオブジェクト
        let filteredImage:CIImage = (filter?.outputImage)!
        // 矩形情報をセットしてレンダリング
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        cameraImageView.image = outputImage
    }
    func Filter6() {
        let filterimage3: CIImage = CIImage(image: originalimage)!
        let filter = CIFilter(name: "CISepiaTone")
        // setValueで対象の画像、効果を指定する
        filter?.setValue(filterimage3, forKey: kCIInputImageKey) // フィルタをかける対象の写真
        // フィルタ処理のオブジェクト
        let filteredImage:CIImage = (filter?.outputImage)!
        // 矩形情報をセットしてレンダリング
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        cameraImageView.image = outputImage
    }
    func Filter7() {
        let filterimage3: CIImage = CIImage(image: originalimage)!
        let filter = CIFilter(name: "CIPhotoEffectProcess")
        // setValueで対象の画像、効果を指定する
        filter?.setValue(filterimage3, forKey: kCIInputImageKey) // フィルタをかける対象の写真
        // フィルタ処理のオブジェクト
        let filteredImage:CIImage = (filter?.outputImage)!
        // 矩形情報をセットしてレンダリング
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        cameraImageView.image = outputImage
    }
    func Filter8() {
        let filterimage3: CIImage = CIImage(image: originalimage)!
        let filter = CIFilter(name: "CIFalseColor")
        // setValueで対象の画像、効果を指定する
        filter?.setValue(filterimage3, forKey: kCIInputImageKey) // フィルタをかける対象の写真
        // フィルタ処理のオブジェクト
        let filteredImage:CIImage = (filter?.outputImage)!
        // 矩形情報をセットしてレンダリング
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        cameraImageView.image = outputImage
    }
    func Filter9() {
        let filterimage3: CIImage = CIImage(image: originalimage)!
        let filter = CIFilter(name: "CIHexagonalPixellate")
        // setValueで対象の画像、効果を指定する
        filter?.setValue(filterimage3, forKey: kCIInputImageKey) // フィルタをかける対象の写真
        // フィルタ処理のオブジェクト
        let filteredImage:CIImage = (filter?.outputImage)!
        // 矩形情報をセットしてレンダリング
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        cameraImageView.image = outputImage
    }
    func Filter10() {
        let filterimage3: CIImage = CIImage(image: originalimage)!
        let filter = CIFilter(name: "CIColorMonochrome")
        // setValueで対象の画像、効果を指定する
        filter!.setValue(filterimage3, forKey: kCIInputImageKey) // フィルタをかける対象の写真
        filter?.setValue(CIColor(red: CGFloat(redcount), green: CGFloat(greencount), blue: CGFloat(bluecount)), forKey: kCIInputColorKey) //フィルタパラメータ設定
        filter?.setValue(1.0, forKey: kCIInputIntensityKey)
        let filteredImage:CIImage = (filter?.outputImage)!
        // 矩形情報をセットしてレンダリング
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        cameraImageView.image = outputImage
    }
    func Filter11() {
        let filterimage3: CIImage = CIImage(image: originalimage)!
        let filter = CIFilter(name: "CICrystallize")
        // setValueで対象の画像、効果を指定する
        filter?.setValue(filterimage3, forKey: kCIInputImageKey) // フィルタをかける対象の写真
        // フィルタ処理のオブジェクト
        let filteredImage:CIImage = (filter?.outputImage)!
        // 矩形情報をセットしてレンダリング
        let ciContext:CIContext = CIContext(options: nil)
        let imageRef = ciContext.createCGImage(filteredImage, from: filteredImage.extent)
        let outputImage = UIImage(cgImage:imageRef!, scale:1.0, orientation:UIImageOrientation.up)
        cameraImageView.image = outputImage
    }
    
    //func hahahaha -> func filterChange
   @IBAction func filterChange() {
    
    if counter >= 1{
        if count == 0 {
            self.colorFilter()
        }else if count == 1 {
            self.mozaikFilter()
        }else if count == 2 {
            self.Filter3()
        }else if count == 3 {
            self.Filter4()
        }else if count == 4 {
            self.Filter5()
        }else if count == 5 {
            self.Filter6()
        }else if count == 6 {
            self.Filter7()
        }else if count == 7 {
            self.Filter8()
        }else if count == 8 {
            self.Filter9()
        }else if count == 9 {
            self.Filter10()
        }else if count == 10 {
            self.Filter11()
        }
    }


    }
    func a1() {
        
    }
    func b1() {
        mozaikcount = mozaikcount + 1
        hiddenlabel1.text = String(mozaikcount)
    }
    func c1() {
        mozaikcount2 = mozaikcount2 + 1
        hiddenlabel1.text = String(mozaikcount2)
    }
    func d1() {
        
    }
    func e1() {
        
    }
    func f1() {
        
    }
    func g1() {
        
    }
    func h1() {
        
    }
    func i1() {
        
    }
    func a2() {
        
    }
    func b2() {
        mozaikcount = mozaikcount - 1
        hiddenlabel1.text = String(mozaikcount)
    }
    func c2() {
        mozaikcount2 = mozaikcount2 - 1
        hiddenlabel1.text = String(mozaikcount2)
    }
    func d2() {
        
    }
    func e2() {
        
    }
    func f2() {
        
    }
    func g2() {
        
    }
    func h2() {
        
    }
    func i2() {
        
    }

    //func control1 -> func saidoPlus
    @IBAction func saidoPlus() {
        if count == 0 {
            self.a1()
        }else if count == 1 {
            self.b1()
        }else if count == 2 {
            self.c1()
        }else if count == 3 {
            self.d1()
        }else if count == 4 {
            self.e1()
        }else if count == 5 {
            self.f1()
        }else if count == 6 {
            self.g1()
        }else if count == 7 {
            self.h1()
        }else if count == 8 {
            self.i1()
        }
    }
    
    //func control2 -> func saidoMinus
    @IBAction func saidoMinus() {
        if count == 0 {
            self.a2()
        }else if count == 1 {
            self.b2()
        }else if count == 2 {
            self.c2()
        }else if count == 3 {
            self.d2()
        }else if count == 4 {
            self.e2()
        }else if count == 5 {
            self.f2()
        }else if count == 6 {
            self.g2()
        }else if count == 7 {
            self.h2()
        }else if count == 8 {
            self.i2()
        }

    }
    //func filtercontrol() -> func filterControl()
    @IBAction func filterControl() {
        count3 = count3 + 1
        if count3 >= 2 {
            count3 = 0
        }
        if count3 == 1 {
            //変更
            saidoView.isHidden = true
            hiddenbutton1.isHidden = true
            hiddenbutton2.isHidden = true
            hiddenlabel1.isHidden = true
            green.isHidden = true
            red.isHidden = true
            blue.isHidden = true
            greenlabel.isHidden = true
            redlabel.isHidden = true
            bluelabel.isHidden = true
            greencounter.isHidden = true
            redcounter.isHidden = true
            bluecounter.isHidden = true
            green2.isHidden = true
            red2.isHidden = true
            blue2.isHidden = true
            //変更
            RGBView.isHidden = true
            green.isHidden = true
            red.isHidden = true
            blue.isHidden = true
            greenlabel.isHidden = true
            redlabel.isHidden = true
            bluelabel.isHidden = true
            greencounter.isHidden = true
            redcounter.isHidden = true
            bluecounter.isHidden = true
            green2.isHidden = true
            red2.isHidden = true
            blue2.isHidden = true
            //書かれていたのでコメントアウト
            //hiddenimageview2.isHidden = true
        }else if count3 == 1 && count == 9  {
            green.isHidden = false
            red.isHidden = false
            blue.isHidden = false
            greenlabel.isHidden = false
            redlabel.isHidden = false
            bluelabel.isHidden = false
            greencounter.isHidden = false
            redcounter.isHidden = false
            bluecounter.isHidden = false
            green2.isHidden = false
            red2.isHidden = false
            blue2.isHidden = false
            //変更
            RGBView.isHidden = false
        }else if count3 == 1 && count == 1{
            //変更
            saidoView.isHidden = false
            hiddenbutton1.isHidden = false
            hiddenbutton2.isHidden = false
            hiddenlabel1.isHidden = false

        }else if count3 == 1 && count == 2{
            //変更
            saidoView.isHidden = false
            hiddenbutton1.isHidden = false
            hiddenbutton2.isHidden = false
            hiddenlabel1.isHidden = false
            
        }

        if count == 1{
            hiddenlabel1.text = String(mozaikcount)
        }else if count == 2 {
            hiddenlabel1.text = String(mozaikcount2)
        }
        if count == 9 {
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "next")
            present(nextView, animated: true, completion: nil)
        }
    
    }
    

    @IBAction func greenplus() {
    greencount = greencount + 0.1
        greencounter.text = String(greencount)
    }
    @IBAction func greenminus() {
        greencount = greencount - 0.1
        greencounter.text = String(greencount)
    }
    @IBAction func redplus(){
        redcount = redcount + 0.1
        redcounter.text = String(redcount)
        
    }
    @IBAction func redminus(){
        redcount = redcount - 0.1
        redcounter.text = String(redcount)
        
    }
    @IBAction func blueplus() {
        bluecount = bluecount + 0.1
        bluecounter.text = String(bluecount)
        
    }
   
    @IBAction func blueminus(){
        bluecount = bluecount - 0.1
        bluecounter.text = String(bluecount)

    }
    @IBAction func snsPhoto() {
        let shereText = "テキストを書き込んでください"
        
        let shereImage = cameraImageView.image!
        let activityItems: [Any] = [shereText,shereImage]
        
        let activityViewcontroller = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let excludedActivityTypes = [UIActivityType.postToWeibo, .saveToCameraRoll, .print]
        
        activityViewcontroller.excludedActivityTypes = excludedActivityTypes
        
        present(activityViewcontroller, animated: true, completion: nil)
    }



}


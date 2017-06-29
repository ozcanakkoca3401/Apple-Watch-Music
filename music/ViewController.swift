
//
//  ViewController.swift
//  music
//
//  Created by ozcan akkoca on 4.05.2015.
//  Copyright (c) 2015 ozcan akkoca. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

var audioPlayer = AVAudioPlayer()



class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    

    @IBOutlet weak var labelGecenSure: UILabel!
    @IBOutlet weak var durumGostergesi: UISlider!
    @IBOutlet weak var labelCalanParca: UILabel!
    
    @IBOutlet weak var buttonOynat: UIButton!
    @IBOutlet weak var buttonDurdur: UIButton!
    @IBOutlet weak var buttonYenidenBaslat: UIButton!
    
    var sesOynatici : AVAudioPlayer!
    var sesURL : String! // "file://" + NSBundle.mainBundle().pathForResource(isim, ofType: "mp3")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.HandleWatchCommunication(_:)), name: NSNotification.Name(rawValue: "WatchWantsToCommunicateWithiPhone"), object: nil)
        
        
        labelCalanParca.text = ""
        sesURL = "file://" + Bundle.main.path(forResource: "ornek", ofType: "mp3")!
        
        let url:URL = URL(string: sesURL)!
        
        
        do {
          sesOynatici = try AVAudioPlayer(contentsOf: url)
            
        } catch {
            print("error loading file")
            // couldn't load file :(
        }
        sesOynatici.prepareToPlay()
        sesOynatici.delegate = self
        
   
        
        buttonYenidenBaslat.isEnabled = false
        buttonDurdur.isEnabled = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func HandleWatchCommunication(_ notification: Notification) {
        
        
        if let buttonPressedIndex = notification.object as? String {
            
            switch(buttonPressedIndex) {
            case "1":
                sesOynatici.play()
                Oynat2("Bicycle")
                break;
            case "2":
                sesOynatici.play()
                Oynat2("GoRightAhead")

                break;
            case "3":
                sesOynatici.play()
                Oynat2("Royals")

                break;
            case "4":
                sesOynatici.play()
                Oynat2("Bicycle")

                
                break;
            case "5":
                sesOynatici.pause()
                
                buttonDurdur.isEnabled = false
                buttonYenidenBaslat.isEnabled = false
                buttonOynat.isEnabled = true
                break;
            default:
                break;
            }
        }
     
      
        
    }
    
    func Oynat2(_ muzik : String) {
        //isim = sender as! String
        
        
        sesURL = "file://" + Bundle.main.path(forResource: muzik, ofType: "mp3")!
        
        let url:URL = URL(string: sesURL)!
        
        do {
            sesOynatici = try AVAudioPlayer(contentsOf: url)
            
        } catch {
            print("error loading file")
            // couldn't load file :(
        }
        sesOynatici.prepareToPlay()
        sesOynatici.delegate = self
        
        sesOynatici.play()
        labelCalanParca.text = sesOynatici.url!.lastPathComponent
        durumGostergesi.maximumValue = Float(sesOynatici.duration)
        
        buttonDurdur.isEnabled = true
        buttonOynat.isEnabled = false
        buttonYenidenBaslat.isEnabled = true;
        
        
        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.guncelle), userInfo: nil, repeats: true)
        
    }

    
    @IBAction func Oynat(_ sender: AnyObject) {
        //isim = sender as! String

        
       

        sesOynatici.play()
        labelCalanParca.text = sesOynatici.url!.lastPathComponent
        durumGostergesi.maximumValue = Float(sesOynatici.duration)
        
        buttonDurdur.isEnabled = true
        buttonOynat.isEnabled = false
        buttonYenidenBaslat.isEnabled = true;
      

        
        _ = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.guncelle), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func kaydir(_ sender: AnyObject){
        sesOynatici.currentTime = Double(self.durumGostergesi.value);
    }
    
    
    func guncelle(){
        durumGostergesi.value = Float(sesOynatici.currentTime);
        labelGecenSure.text = gecenZamaniMetinOlarakAl(durumGostergesi.value);
    }
    
    @IBAction func Durdur(_ sender: AnyObject) {
        sesOynatici.pause()
        
        buttonDurdur.isEnabled = false
        buttonYenidenBaslat.isEnabled = false
        buttonOynat.isEnabled = true
    }
    
    
    @IBAction func YenidenBaslat(_ sender: AnyObject) {
        sesOynatici.stop();
        sesOynatici.currentTime = 0
        sesOynatici.play();
    }
    
    func gecenZamaniMetinOlarakAl(_ gecenZaman : Float) -> String{
        
        let gecenZamanTamSayi: Int = Int(gecenZaman + 0.5)
        
        let kalan: Int = gecenZamanTamSayi % 3600;
        
        let saat : Int = gecenZamanTamSayi / 3600;
        let dakika : Int = kalan / 60;
        let saniye : Int = kalan % 60;
        
        let labelValue: String = String(format: "%02d:%02d:%02d", saat,dakika,saniye)
        
        return labelValue;
        
    }
    
}


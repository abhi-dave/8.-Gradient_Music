//
//  ViewController.swift
//  8. Gradient_Music
//
//  Created by Abhishek Dave on 15/12/17.
//  Copyright © 2017 Abhishek Dave. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    private var audioPlayer:AVAudioPlayer?
    var gradientLayer = CAGradientLayer()
    var timer: Timer?
    var isPlaying = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func musicButtonPressed(){
        if isPlaying{
            timer?.invalidate()
            audioPlayer?.stop()
            isPlaying = false
        }else{
            play(for: "My Soul, your Beats! [full ver.] - Angel Beats! OP [Piano]", type: "mp3")
            timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(gradientColour), userInfo: nil, repeats: true)
        }
    }
    
    
    func play(for resource: String, type: String){
        guard  let path = Bundle.main.path(forResource: resource, ofType: type) else {
            print("Error Finding Path")
            return
        }
        let sound = URL(fileURLWithPath: path)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: sound)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
        }catch{
            print("Error Playing Sound")
        }
        isPlaying = true
    }
    
    @objc func gradientColour(){
        gradientLayer.frame = view.bounds
        let x = CGFloat(arc4random_uniform(255))
        let y = CGFloat(arc4random_uniform(255))
        let z = CGFloat(arc4random_uniform(255))
        let color1 = UIColor(red: z / 255.0, green: x / 255.0, blue: y / 255.0, alpha: 1).cgColor
        let color2 = UIColor(red: x / 255.0, green: z / 255.0, blue: y / 255.0, alpha: 1).cgColor
        let color3 = UIColor(red: x / 255.0, green: y/255.0, blue: z / 255.0, alpha: 1).cgColor
        
       gradientLayer.colors = [color1,color2,color3]
      //  gradientLayer.colors = [UIColor.yellow.cgColor, UIColor.blue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }

}


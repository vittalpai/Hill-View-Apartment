//
//  LiveFeedViewController.swift
//  HillView-Apartment
//
//  Created by Vittal Pai on 7/11/18.
//  Copyright © 2018 Vittal Pai. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class LiveFeedViewController: UIViewController {

    var reloadImageTimer:Timer = Timer()
    @IBOutlet weak var liveFeedImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadImageTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(reloadImage), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        reloadImageTimer.invalidate()
    }
    
    
    
    @objc func reloadImage()
    {
        URLCache.shared.removeAllCachedResponses()
        Alamofire.request("https://dl.dropboxusercontent.com/s/mru9qumcme99ucs/test.jpg").responseImage { response in
            debugPrint(response)
            
            if let image = response.result.value {
                self.liveFeedImage.image = image
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

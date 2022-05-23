//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Muhammad Saud Anwar on 23/05/2022.
//

import UIKit

class WeatherDetailViewController: UIViewController {

    class func instantiateFromStoryboard() -> WeatherDetailViewController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as! WeatherDetailViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

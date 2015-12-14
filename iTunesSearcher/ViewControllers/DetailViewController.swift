//
//  DetailViewController.swift
//  iTunesSearcher
//
//  Created by Bryan Cimo on 12/13/15.
//  Copyright © 2015 Bryan Cimo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController
{
    //  MARK: - Vars
    
    @IBOutlet weak var mainImage: AsyncImageView!
    @IBOutlet weak var trackName: UILabel!
    @IBOutlet weak var longDescription: UITextView!
    @IBOutlet weak var contentAdvisoryRating: UILabel!
    
    var selectedItemIndex = 0
    var itemDetailDictionary = NSDictionary()
    
    //  MARK: - Init
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupFields()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        longDescription.setContentOffset(CGPointMake(0, 0), animated: false)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //  MARK: - IBAction
    
    @IBAction func tappedPreview(sender: UIButton)
    {
        if let url = itemDetailDictionary["trackViewUrl"] as? String
        {
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        }
    }
    
    //  MARK: -  Funcs
    
    func setupFields()
    {
        itemDetailDictionary = DataCache.sharedInstance.searchItemsList[selectedItemIndex] as! NSDictionary
        mainImage.imageURL = NSURL(string: itemDetailDictionary["artworkUrl100"] as! String)
        trackName.text = itemDetailDictionary["trackName"] as? String
        longDescription.text = itemDetailDictionary["longDescription"] as? String
        let ratingText = itemDetailDictionary["contentAdvisoryRating"] as? String ?? ""
        contentAdvisoryRating.text = "Rated: \(ratingText)"
    }
}

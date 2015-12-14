//
//  SearchListViewController.swift
//  iTunesSearcher
//
//  Created by Bryan Cimo on 12/13/15.
//  Copyright © 2015 Bryan Cimo. All rights reserved.
//

import UIKit

class SearchListViewController: UIViewController, iCarouselDataSource, iCarouselDelegate
{
    //  MARK: - Vars
    
    @IBOutlet weak var carousel: iCarousel!
    
    var selectedItemIndex = -1
    let imageTag = 100
    let nameLabelTag = 101
    let detailLabelTag = 102
    
    //  MARK: - Init
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        carousel.type = .CoverFlow
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //  MARK: - iCarousel Delegates
    
    func carousel(carousel: iCarousel, viewForItemAtIndex index: Int, reusingView view: UIView?) -> UIView
    {
        var label: UILabel
        var itemView: UIImageView
        var previewImage = AsyncImageView(frame: CGRectMake(10, 30, 100, 100))
        
        if (view == nil)
        {
            itemView = UIImageView(frame:CGRect(x:0, y:0, width:200, height:200))
            itemView.image = UIImage(named: "page")
            itemView.contentMode = .Center
            
            label = UILabel(frame:itemView.bounds)
            
            setupNewViews(label, previewImage: previewImage)
            
            itemView.addSubview(previewImage)
            itemView.addSubview(label)
        }
        else
        {
            itemView = view as! UIImageView;
            label = itemView.viewWithTag(nameLabelTag) as! UILabel!
            previewImage = itemView.viewWithTag(imageTag) as! AsyncImageView
        }
        
        previewImage.imageURL = NSURL(string: DataManagerCache.sharedInstance.searchItemsList[index]["artworkUrl100"] as! String)
        
        label.text = DataManagerCache.sharedInstance.searchItemsList[index]["trackName"] as? String
        
        return itemView
    }
    
    func setupNewViews(label: UILabel, previewImage: AsyncImageView)
    {
        label.backgroundColor = UIColor.clearColor()
        label.textAlignment = .Center
        label.font = label.font.fontWithSize(12)
        label.frame = CGRectMake(10, 140, 190, 40)
        label.tag = nameLabelTag
        
        previewImage.contentMode = .ScaleAspectFit
        previewImage.tag = imageTag
    }
    
    func numberOfItemsInCarousel(carousel: iCarousel) -> Int
    {
        return DataManagerCache.sharedInstance.searchItemsList.count
    }
    
    func carousel(carousel: iCarousel, valueForOption option: iCarouselOption, withDefault value: CGFloat) -> CGFloat
    {
        if (option == .Spacing)
        {
            return value * 1.3
        }
        return value
    }
    
    func carousel(carousel: iCarousel, didSelectItemAtIndex index: Int)
    {
        selectedItemIndex = index
        print("selected: \(index)")
        performSegueWithIdentifier("segueShowDetails", sender: self)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let destinationViewController = segue.destinationViewController as? DetailViewController
        {
            destinationViewController.selectedItemIndex = selectedItemIndex
        }
        
    }

}

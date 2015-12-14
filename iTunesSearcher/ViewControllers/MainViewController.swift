//
//  ViewController.swift
//  iTunesSearcher
//
//  Created by Bryan Cimo on 12/7/15.
//  Copyright © 2015 Bryan Cimo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITextFieldDelegate
{
    //  MARK: - Vars
    
    @IBOutlet var searchText: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var mediaType = "movies"

    //  MARK: -  Init
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func viewDidDisappear(animated: Bool)
    {
        spinner.hidden = true
    }
    
    //  MARK: -  IBAction
    
    @IBAction func textFieldChange(sender: UITextField)
    {
        searchButton.enabled = false
        if sender.text?.isEmpty == false
        {
            searchButton.enabled = true
        }
    }
    
    @IBAction func tappedSearch(sender: UIButton)
    {
        startSearch()
    }
    
    @IBAction func changedSegmentedControl(sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex
        {
        case 0:
            mediaType = "movie"
            break
        case 1:
            mediaType = "music"
            break
        case 2:
            mediaType = "all"
            break
        default:
            mediaType = "all"
        }
    }
    
    //  MARK: - TextField
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        startSearch()
        return true
    }
    
    //  MARK: - Funcs
    
    func startSearch()
    {
        spinner.hidden = false
        DataManagerCache.sharedInstance.searchForItems(searchText.text!)
        performSegueWithIdentifier("segueShowList", sender: self)
    }
}


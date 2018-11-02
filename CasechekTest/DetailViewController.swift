//
//  DetailViewController.swift
//  CasechekTest
//
//  Created by Jared Wheeler on 11/1/18.
//  Copyright © 2018 Jared Wheeler. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    func configureView() {
        if let detail = detailItem {
            if let detailLabel = detailDescriptionLabel,
                let dateLabel = dateLabel {
                detailLabel.text = detail.name
                dateLabel.text = detail.date
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    var detailItem: Site? {
        didSet {
            configureView()
        }
    }
}


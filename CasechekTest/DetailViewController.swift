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
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!

    func configureView() {
        if let detail = detailItem {
            if let detailLabel = detailDescriptionLabel,
                let dateLabel = dateLabel,
                let addressLabel = addressLabel,
                let statusLabel = statusLabel {
                detailLabel.text = detail.name
                addressLabel.text = detail.address
                dateLabel.text = detail.date?.description
                statusLabel.text = detail.status
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


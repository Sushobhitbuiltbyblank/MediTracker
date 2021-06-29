//
//  HistoryTableViewCell.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 28/06/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateL: UILabel!
    @IBOutlet weak var scoreL: UILabel!
    @IBOutlet weak var stackV: UIStackView!
    @IBOutlet private weak var containerView : UIView! {
        didSet {
            containerView.layer.borderColor = UIColor.gray.cgColor
            containerView.layer.borderWidth = 1
        }
    }

    var cellModel:HistoryCellModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
    }
    
    func setUp() {
        guard let cellObject = cellModel else {
            return
        }
        self.dateL.text = cellObject.dateString
        self.scoreL.text = "\(cellObject.score)"
        self.scoreL.textColor = getScoreColor(score: cellObject.score)
        for record in cellObject.records ?? [] {
            var lableArr:[UILabel] = [UILabel]()
            let stringArr = record.components(separatedBy: " ")
            if stringArr.count > 1 {
                let greetL = UILabel()
                greetL.font = UIFont(name: "Helvetica Neue Light", size: 16)
                greetL.textColor = UIColor.gray
                greetL.text = stringArr[0]
                lableArr.append(greetL)
                
                let timeL = UILabel()
                timeL.font = UIFont(name: "Helvetica Neue Bold", size: 16)
                timeL.text = "\(stringArr[1]) \(stringArr[2])"
                timeL.addConstraint(NSLayoutConstraint(
                                        item: timeL,
                                        attribute: .width,
                                        relatedBy: .equal,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0,
                                        constant: 90))
                lableArr.append(timeL)
            }
            let HstackView = UIStackView(arrangedSubviews: lableArr)
            HstackView.axis = .horizontal
            HstackView.distribution = .fillEqually
            HstackView.alignment = .firstBaseline
            HstackView.spacing = 8
            HstackView.translatesAutoresizingMaskIntoConstraints = false
            self.stackV.insertArrangedSubview(HstackView, at: 0)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func getScoreColor(score:Int) -> UIColor? {
        switch score {
        case 0...40 :
            return UIColor(named: "LowScore")
        case 41...70 :
            return UIColor(named: "MediumScore")
        default:
            return UIColor(named: "HighScore")
        }
    }
    
}

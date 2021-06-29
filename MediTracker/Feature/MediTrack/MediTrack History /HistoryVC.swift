//
//  HistoryVC.swift
//  MediTracker
//
//  Created by Sushobhit.Jain on 27/06/21.
//

import UIKit

class HistoryVC: BaseVC, Storyboarded {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: String(describing: HistoryTableViewCell.self),
                                     bundle: nil),
                               forCellReuseIdentifier: String(describing: HistoryTableViewCell.self))
         
            tableView.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var backBtn: UIButton!
    
    var viewModel:HistoryViewModel!
    
    var coordinatorCallback: ((HistoryCoordinator.Destination)-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        // Do any additional setup after loading the view.
    }
    
    func setUp() {
        viewModel.getHistory()
        self.viewModel.refreshUI = { _ in
            self.tableView.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.coordinatorCallback?(.back)
    }

}

extension HistoryVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.historyRecords?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryTableViewCell.self)) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.cellModel = self.viewModel.historyRecords?[indexPath.item]
        cell.setUp()
        return cell
    }
    
    
    
}

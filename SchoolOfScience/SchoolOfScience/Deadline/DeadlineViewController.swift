//
//  FilterViewController.swift
//  SchoolOfScience
//
//  Created by Jacky Tang on 2/5/19.
//  Copyright © 2019 Jacky Tang. All rights reserved.
//

import UIKit

class DeadlineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var deadLineTableView: UITableView!

    var deadlineDates: [String] = [String]()
    var deadLineCellViewModels: [DeadLineViewModel] = [DeadLineViewModel]()

    let calenderView: CalenderView = {
        let v=CalenderView(theme: MyTheme.dark)
        v.translatesAutoresizingMaskIntoConstraints=false
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        self.title = "My Calender"
        self.navigationController?.navigationBar.isTranslucent=false
        self.view.backgroundColor=Style.bgColor

        view.addSubview(calenderView)
        calenderView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive=true
        calenderView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -12).isActive=true
        calenderView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 12).isActive=true
        calenderView.heightAnchor.constraint(equalToConstant: 400).isActive=true

        highlightDeadLine()

        //add highlight action to left and right button
        calenderView.monthView.btnLeft.addTarget(self, action: #selector(newBtnLeftRightAction(sender:)), for: .touchUpInside)
        calenderView.monthView.btnRight.addTarget(self, action: #selector(newBtnLeftRightAction(sender:)), for: .touchUpInside)

    }


    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        calenderView.myCollectionView.collectionViewLayout.invalidateLayout()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return deadLineCellViewModels.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deadlineCell", for: indexPath) as! DeadLineTableViewCell
        cell.dateLabel.text = deadLineCellViewModels[indexPath.row].date
        cell.tittleLabel.text = deadLineCellViewModels[indexPath.row].title
        cell.departmentLabel.text = deadLineCellViewModels[indexPath.row].department
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DeadlineModel.upDateDisplayingDeadline(title: deadLineCellViewModels[indexPath.row].title!, content: deadLineCellViewModels[indexPath.row].content!, date: deadLineCellViewModels[indexPath.row].date, image: deadLineCellViewModels[indexPath.row].image)
        self.performSegue(withIdentifier: "deadlineSegue", sender: nil)

    }

    @IBAction func LogoTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func newBtnLeftRightAction(sender: UIButton) {
        highlightDeadLine()
    }

    private func getNumberDateFromSeconds(seconds: Int) -> String {
        let timeInterval = seconds/1000
        let myDate = Date(timeIntervalSince1970: Double(timeInterval))
        let formatter = DateFormatter()
        formatter.dateFormat = "d-M-yyyy"
        return formatter.string(from: myDate as Date)
    }

    private func highlightDeadLine() {
        self.showLoading()
        JsonManager.getDeadLineFeeds() {feeds in
            DispatchQueue.main.async {
                guard let feeds = feeds else { return }
                for feed in feeds {
                    guard let deadlineDate = feed.deadlineDate else { return }
                    self.deadlineDates.append(self.getNumberDateFromSeconds(seconds: deadlineDate))
                }
                for cell in self.calenderView.myCollectionView.visibleCells as! [dateCVCell] {
                    for date in self.deadlineDates {
                        let dayLabel = cell.subviews[1] as! UILabel
                        if date == "\(dayLabel.text!)-\(self.calenderView.currentMonthIndex)-\(self.calenderView.currentYear)" {
                            cell.backgroundColor = Colors.darkRed
                        }
                    }
                }
                self.calenderView.reloadInputViews()
                self.clearLoading()
            }
        }
    }
}

//
//  SubTitleVC.swift
//  AvPlayerStreaming
//
//  Created by SAIF ULLAH on 28/11/2021.
//

import UIKit

class SubTitleVC: UITableViewController,ThreadType {

    var appPlayer : AppPlayer?
    private lazy var dataSource : [TrackType] = {
     prePareDataSource()
    }()
    private lazy var doneBtn : UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: self.view.frame.width-100, y: 25, width: 100, height: 30)
        button.setTitle(Resources.strings.titleDone, for: .normal)
        button.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2)
       // button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.reloadData()
        self.view.addSubview(doneBtn)
        self.view.bringSubviewToFront(doneBtn)
        // Do any additional setup after loading the view.
    }
    @objc func doneAction() {
        self.dismiss(animated: true, completion: nil)
    }
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SubTitleVCTableSectionType.allCases.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].items?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: dataSource[indexPath.section].sectionType?.cellIdentifier ?? "") as? TbInfoCell else {
            return UITableViewCell()
        }
        if let text = dataSource[indexPath.section].items?[indexPath.row].disPlayName, let isSlected = dataSource[indexPath.section].items?[indexPath.row].isSeleced {
            cell.update(text: text, isSelected: isSlected)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return dataSource[section].sectionType?.title
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource[indexPath.section].items?.first{$0.isSeleced == true}?.isSeleced = false
        dataSource[indexPath.section].items?[indexPath.row].isSeleced = true
        tableView.reloadData()
        if let group = dataSource[indexPath.section].secTionGroup,let option = dataSource[indexPath.section].items?[indexPath.row].option {
            ruOnMain {
                self.appPlayer?.player?.currentItem?.select(option, in: group)
            }
            
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
    
}
extension SubTitleVC {
    private func prePareDataSource()->[TrackType] {
        guard let plyerItem = appPlayer?.player?.currentItem else {
            return []
        }
        let asset = plyerItem.asset
        let data = asset.availableMediaCharacteristicsWithMediaSelectionOptions.compactMap({ value -> TrackType in
            let data = TrackType()
            data.sectionType = value == .audible ? .Audio : .subTitle
            if let group = asset.mediaSelectionGroup(forMediaCharacteristic: value){
                data.secTionGroup = group
                data.items = group.options.compactMap({
                    TrackDetail(isSeleced: plyerItem.currentMediaSelection.selectedMediaOption(in: group) == $0, disPlayName: $0.displayName, option: $0)
                })
            }
            return data
        })
        return data
    }
}

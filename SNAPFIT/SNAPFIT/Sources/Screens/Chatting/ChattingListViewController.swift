//
//  ChattingListViewController.swift
//  SNAPFIT
//
//  Created by 강유진 on 2023/05/12.
//

import UIKit

class ChattingListViewController: ListTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableCell") ?? ListTableViewCell()
        
        setCellAsChattingList(cell: cell as! ListTableViewCell)
        return cell
    }
    
    
}

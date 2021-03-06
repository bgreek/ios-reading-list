//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Breena Greek on 2/14/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateeHadBeenRead(for: book)
        tableView.reloadData()
        
    }
    
    let bookController = BookController()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.unreadBooks.count
        } else {
            return bookController.readBooks.count
        }
        
    }

    func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0{
            return bookController.unreadBooks[indexPath.row]
        } else {
            return bookController.readBooks[indexPath.row]
        
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as? BookTableViewCell else { return UITableViewCell() }
        cell.delegate = self
        cell.book = bookFor(indexPath: indexPath)
        return cell
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "readingListDetailSegue" {
            if let indexPath = tableView.indexPathForSelectedRow, let DetailVC = segue.destination as? BookDetailViewController {
                DetailVC.book = bookFor(indexPath: indexPath)
                DetailVC.bookController = bookController
            }
        } else if segue.identifier == "addDetailSegue"{
            if let AddVC = segue.destination as? BookDetailViewController {
                AddVC.bookController = bookController
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return "Currently Reading \(bookController.unreadBooks.count)"
            }
        } else if section == 1 {
            if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
                return "Read Books \(bookController.readBooks.count)"
            }
        }
        return nil
    }
}


    



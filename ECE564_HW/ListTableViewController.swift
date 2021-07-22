//
//  ListTableViewController.swift
//  ECE564_HW
//
//  Created by Andrew Krier on 3/10/21.
//  Copyright © 2021 ECE564. All rights reserved.
//

import UIKit

/*
 * Search functionality heavily adapted from this tutorial:
 * https://www.raywenderlich.com/4363809-uisearchcontroller-tutorial-getting-started
 */

let alert = UIAlertController(title: "HTTPS Request to reload data", message: "Would you like to refresh the data from the server?", preferredStyle: .alert)
let cacheAlert = UIAlertController(title: "Clear Cache?", message: "Are you sure you would like to clear the local storage?", preferredStyle: .alert)
let downloadAlert = UIAlertController(title: "Download Complete", message: "Download from the server is complete", preferredStyle: .alert)

class ListTableViewController: UITableViewController, URLSessionDelegate {
    
    var filteredPeople : [DukePerson] = [DukePerson]()
    var isSearchBarEmpty : Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering : Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredPeople = DataBase.list().filter { (person : DukePerson) -> Bool in
            return "\(person.firstName) \(person.lastName) \(person.netID)".lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    @IBOutlet var refreshButton: UIBarButtonItem!
    @IBAction func refreshPeople() {
        self.present(alert, animated: true, completion: tableView.reloadData)
    }
    @IBAction func clearCache() {
        self.present(cacheAlert, animated: true, completion: nil)
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    func resetCache() -> Void {
        DataBase.clear()
        _ = CodableDukePerson.saveDukePeople(DataBase.list())
        tableView.reloadData()
    }
    
    func refreshFromServer() -> Void {
        guard let loginData = loginString.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        self.view.endEditing(true)
        let url = URL(string: uploadString)
        var request = URLRequest(url: url!)
        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if response != nil {
                print(response!)
                let decoder = JSONDecoder()
                
                do {
                    let decodedPeople = try decoder.decode([CodableDukePerson].self, from: data!)
                    DataBase.people = [[DukePerson]]()
                    for cdp in decodedPeople {
                        DataBase.add(dp: cdp.makeDukePerson())
                    }
                    let _ = CodableDukePerson.saveDukePeople(DataBase.list())
                } catch _ {
                    print("Error")
                }
            } else {
                print("Error")
            }
        }
        task.resume()
        self.present(downloadAlert, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 75
        DataBase.start()
        alert.addAction(UIAlertAction(title:NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in self.refreshFromServer() }))
        alert.addAction(UIAlertAction(title:NSLocalizedString("Cancel", comment: "End"), style: .default, handler: { _ in }))
        cacheAlert.addAction(UIAlertAction(title:NSLocalizedString("Yes", comment: "Default action"), style: .default, handler: { _ in self.resetCache() }))
        cacheAlert.addAction(UIAlertAction(title:NSLocalizedString("Cancel", comment: "End"), style: .default, handler: { _ in }))
        downloadAlert.addAction(UIAlertAction(title:NSLocalizedString("Ok", comment: "End"), style: .default, handler: { _ in self.tableView.reloadData()}))
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search People"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        //tableView.register(UINib.init(nibName: "DukePersonViewCell", bundle: nil), forCellReuseIdentifier: "dukePerson")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        if isFiltering {
            return 1
        }
        
        return DataBase.people.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if isFiltering {
            return filteredPeople.count
        }
        
        return DataBase.people[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering {
            return ""
        }
        
        if DataBase.people[section].count == 0 {
            return ""
        }
        
        let t : String = DataBase.people[section][0].team
        
        if t == "None" || t == "none" || t == "NONE" || t == "" {
            return "Student"
        }
        
        return DataBase.people[section][0].team
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dukePerson", for: indexPath) as! DukePersonViewCell
        
        let dp : DukePerson
        
        if isFiltering {
            dp = filteredPeople[indexPath.row]
        } else {
            dp = DataBase.people[indexPath.section][indexPath.row]
        }
        
        cell.profilePic?.image = dp.img
        cell.nameLabel?.text = "\(dp.firstName) \(dp.lastName) (\(dp.netID))"
        cell.descriptionLabel?.text = makeString(p: dp)

        // Configure the cell...

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPerson = DataBase.people[indexPath.section][indexPath.row]
        
        if let viewController = storyboard?.instantiateViewController(identifier: "InformationViewController") as? InformationViewController {
            isUpdate = true
            allowEditing(b: false)
            updatePerson(p: selectedPerson)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    
    /*
     * https://useyourloaf.com/blog/table-swipe-actions/
     */
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: "Edit", handler: { (action, view, completionHandler) in
            self.editPerson(indexPath)
            completionHandler(true)
        })
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete", handler: { (action, view, completionHandler) in
            self.deletePerson(indexPath)
            completionHandler(true)
        })
        
        editAction.backgroundColor = .buttonSliderColor
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [editAction, deleteAction])
    }
    
    func deletePerson(_ i : IndexPath) {
        DataBase.people[i.section].remove(at: i.row)
        let _ = CodableDukePerson.saveDukePeople(DataBase.list())
        tableView.reloadData()
    }
    
    func editPerson(_ i : IndexPath) {
        let selectedPerson = DataBase.people[i.section][i.row]
        
        if let viewController = storyboard?.instantiateViewController(identifier: "InformationViewController") as? InformationViewController {
            isUpdate = true
            allowEditing(b: true)
            updatePerson(p: selectedPerson)
            navigationController?.pushViewController(viewController, animated: true)
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func returnFromAddItem(segue: UIStoryboardSegue) {
        tableView.reloadData()
        isUpdate = false
    }

}

extension ListTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
}


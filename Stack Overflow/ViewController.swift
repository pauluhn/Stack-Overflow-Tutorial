//
//  ViewController.swift
//  Stack Overflow
//
//  Created by Peter Gustafson on 4/9/19.
//  Copyright © 2019 Peter Gustafson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var questions: [Question] = []
    
    // private queue to play around with multi-threading
    let queue = DispatchQueue(label: "ViewController Queue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // TODO: move this to constants
        let baseURL = "https://api.stackexchange.com"
        // TODO: break this up using URLComponents
        let parameters = "/2.2/questions?order=desc&sort=activity&site=stackoverflow"
        let api = API(baseURL: baseURL, parameters: parameters)
        // TODO: this get is being called on main thread (because viewDidLoad is called on main thread)
        // move to our private queue to unblock it
        api.get { (questions) in
            // TODO: question: is it ok to keep a strong ref to self here?
            // if not, what should we do?
            self.questions = questions
            self.queue.async {
                DispatchQueue.main.async {
                    // TODO: how about here?
                    self.tableView.reloadData()
                }
            }
        }
    }

}

// MARK: - UITableView datasource and delegates

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        let question = questions[indexPath.row]
        cell.textLabel?.text = question.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
}

//
//  ViewController.swift
//  air_pollution
//
//  Created by M'haimdat omar on 19-01-2020.
//  Copyright © 2020 M'haimdat omar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Class Attributes
    lazy var label = UILabel()
    lazy var labelType = UILabel()
    lazy var datePicker = UIDatePicker()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8645390868, green: 0.1406893432, blue: 0.119001396, alpha: 1)
        setupLabel()
        setupPicker()
        
    }
    
    // MARK: - Setup the label layout and add it to the subview
    private func setupLabel() {
        
        labelType.translatesAutoresizingMaskIntoConstraints = false
        labelType.font = UIFont(name: "Avenir-Heavy", size: 60)
        labelType.textColor = #colorLiteral(red: 0.000254133367, green: 0.09563607723, blue: 0.6585127711, alpha: 1)
        view.addSubview(labelType)
        labelType.text = "PM2.5\n --------"
        labelType.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        labelType.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        labelType.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir", size: 70)
        label.textColor = #colorLiteral(red: 0.000254133367, green: 0.09563607723, blue: 0.6585127711, alpha: 1)
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: labelType.bottomAnchor, constant: 40).isActive = true
    }
    
    // MARK: - Setup the date picker layout
    private func setupPicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = #colorLiteral(red: 0.8645390868, green: 0.1406893432, blue: 0.119001396, alpha: 1)
        datePicker.setValue(#colorLiteral(red: 0.000254133367, green: 0.09563607723, blue: 0.6585127711, alpha: 1), forKeyPath: "textColor")
        datePicker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
        view.addSubview(datePicker)
        
        datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: view.bounds.height/2).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive = true
    }

    // MARK: - The picker's target
    @objc private func datePickerChanged(picker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year: String = dateFormatter.string(from: picker.date)
        dateFormatter.dateFormat = "MM"
        let month: String = dateFormatter.string(from: picker.date)
        dateFormatter.dateFormat = "dd"
        let day: String = dateFormatter.string(from: picker.date)
        let date = "\(day)\(month)\(year)"
        getPrediction(date: date)
    }
    
    func getPrediction(date: String) {
            
        var request = URLRequest(url: URL(string: "http://127.0.0.1:5000/\(date)23")!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                if let respond = json.values.first {
                    DispatchQueue.main.async {
                        let pollution = respond as! String
                        let pollutionFloat = Float(pollution)
                        let pollutionString = String(format: "%.2f", pollutionFloat!)
                        self.label.text = "\(pollutionString)"
                    }
                }
            } catch {
                print("error")
            }
        })
        
        task.resume()
    }


}


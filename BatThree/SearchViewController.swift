//
//  SearchViewController.swift
//  BatThree
//
//  Created by 林祔利 on 2023/7/16.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var countryTableView: UITableView!
    let popUpButton = UIButton(type: .system)
    var menuTableView: UITableView!
    let titleLabel = UILabel()
    let options = ["台北圓環", "台北市", "台北市", "新竹科學園區", "台北市", "台北市", "松山區"]
    var youBikes = [StationInfo]()
    let buttonLabel = UILabel()
    let buttonImage = UIImageView()
    var filteredData = [StationInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "站點資訊"
        titleLabel.textColor = UIColor(cgColor: #colorLiteral(red: 0.725, green: 0.796, blue: 0.286, alpha: 1).cgColor)
        titleLabel.font = titleLabel.font.withSize(24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        
        // Set up the pop-up button
        // Add the label
        
        buttonLabel.text = "搜尋站點"
        buttonLabel.textColor = UIColor(cgColor: #colorLiteral(red: 0.725, green: 0.796, blue: 0.286, alpha: 1).cgColor)
        buttonLabel.translatesAutoresizingMaskIntoConstraints = false
        popUpButton.addSubview(buttonLabel)
        
        buttonLabel.centerYAnchor.constraint(equalTo: popUpButton.centerYAnchor).isActive = true
        buttonLabel.leadingAnchor.constraint(equalTo: popUpButton.leadingAnchor, constant: 5).isActive = true
        
        
        // Add the image view
        buttonImage.image = UIImage(systemName: "magnifyingglass")
        buttonImage.tintColor = UIColor(red: 0.725, green: 0.796, blue: 0.286, alpha: 1.0)
        buttonImage.contentMode = .scaleAspectFit
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        popUpButton.addSubview(buttonImage)
        buttonImage.centerYAnchor.constraint(equalTo: popUpButton.centerYAnchor).isActive = true
        buttonImage.trailingAnchor.constraint(equalTo: popUpButton.trailingAnchor, constant: -15).isActive = true
        
        
        popUpButton.tintColor = UIColor(red: 0.725, green: 0.796, blue: 0.286, alpha: 1.0)
        popUpButton.addTarget(self, action: #selector(toggleMenu), for: .touchUpInside)
//        // 设置文本偏移
//        popUpButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -270, bottom: 0, right: 0)
//        // 设置图标偏移
//        popUpButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -360)
       
        
        // Style the button
        popUpButton.backgroundColor = UIColor(red: 0xF6/255.0, green: 0xF6/255.0, blue: 0xF6/255.0, alpha: 1.0)
        popUpButton.layer.cornerRadius = 8.0
        popUpButton.setTitleColor(UIColor(cgColor: #colorLiteral(red: 0.725, green: 0.796, blue: 0.286, alpha: 1).cgColor), for: .normal)
        popUpButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        
        // Add the button to your view
        view.addSubview(popUpButton)
        
        let buttonWidth: CGFloat = 330 // 设置宽度值
        // Position the button using Auto Layout
        popUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            popUpButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 160),
            popUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            popUpButton.widthAnchor.constraint(equalToConstant: buttonWidth)
        ])
        

 
        
        // Set up the menu table view
        menuTableView = UITableView()
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.isHidden = true
        menuTableView.layer.cornerRadius = 8.0
        menuTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
        view.addSubview(menuTableView)
        
        // Position the menu table view using Auto Layout
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: popUpButton.bottomAnchor),
            menuTableView.leadingAnchor.constraint(equalTo: popUpButton.leadingAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: popUpButton.trailingAnchor),
            menuTableView.heightAnchor.constraint(equalToConstant: 310) // Adjust the height as needed
        ])

        countryTableView.delegate = self
        countryTableView.dataSource = self
        
        GetInfo.shared.getAllInfo { result in
            switch result {
            case .success(let youbike):
                self.youBikes = youbike
                self.filteredData = youbike
                DispatchQueue.main.async {
                    self.countryTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
               
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        countryTableView.reloadData()
    }
    
    
    
//    override func viewDidLayoutSubviews() {
//            super.viewDidLayoutSubviews()
//
//        popUpButton.imageView?.trailingAnchor.constraint(equalTo: popUpButton.trailingAnchor, constant: 0).isActive = true
//        popUpButton.imageView?.widthAnchor.constraint(equalToConstant: 5).isActive = true
//        popUpButton.imageView?.heightAnchor.constraint(equalToConstant: 5).isActive = true
//
//        popUpButton.titleLabel?.leadingAnchor.constraint(equalTo: popUpButton.leadingAnchor,constant: 10).isActive = true
//
//        }
    
    @IBAction func back(_ sender: Any) {

        dismiss(animated: true)
    }
    
    
    @objc func toggleMenu() {
        menuTableView.isHidden = !menuTableView.isHidden
    }
    
    // MARK: - UITableViewDataSource
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == menuTableView {
            return options.count
        }else if tableView == countryTableView {
            return youBikes.count
        }
        return 0
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == menuTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
            cell.textLabel?.text = options[indexPath.row]
            cell.textLabel?.textColor = UIColor(cgColor: #colorLiteral(red: 0.725, green: 0.796, blue: 0.286, alpha: 1).cgColor)
            return cell
        }else if tableView == countryTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(CountryTableViewCell.self)", for: indexPath) as? CountryTableViewCell else {
                    print("錯誤了")
                    return UITableViewCell()}
            let youBike = youBikes[indexPath.row]
            cell.InfoLabel.text = youBike.sna
            cell.countryLable.text = "臺北市"
            cell.directLabel.text = youBike.sarea
            if indexPath.row % 2 == 1 {
                cell.backgroundColor = UIColor(red: 0xF6/255.0, green: 0xF6/255.0, blue: 0xF6/255.0, alpha: 1.0)
            }
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = options[indexPath.row]
        handleOptionSelection(selectedOption)
        tableView.deselectRow(at: indexPath, animated: true)
        menuTableView.isHidden = true
    }
    
    // Handle the selected option
    func handleOptionSelection(_ option: String) {
        print("Selected option: \(option)")
        // 更新标题文本
        buttonLabel.text = "\(option)"
        buttonImage.image = UIImage(systemName: "magnifyingglass")

        let matchedData = filteredData.filter { $0.sarea == option }
        if !matchedData.isEmpty {
            // 找到符合條件的資料
            youBikes = matchedData
        } else {
            // 沒有找到符合條件的資料，顯示全部資料
            youBikes = filteredData
        }
        DispatchQueue.main.async {
            self.countryTableView.reloadData()
        }
        
        self.view.layoutIfNeeded()
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

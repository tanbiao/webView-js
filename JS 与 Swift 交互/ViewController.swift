//
//  ViewController.swift
//  JS 与 Swift 交互
//
//  Created by 谭彪 on 16/9/28.
//  Copyright © 2016年 QuanQuan. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let dataSource = ["WebView的拦截交互","JSCore交互","语言穿梭机协议(JSExport)"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "JS与Swift的交互"
       
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataSource.count
        
    }
       
    func JumpToJSCoreVC()
    {
        let jsCoreVC = JSCoreVC()
        
        navigationController?.pushViewController(jsCoreVC, animated: true)
    }
    
    func JumpToJSAndOCInterceptVC()
    {
        let jsAndOCInteVC = JSAndOCInterceptVC()
        
        navigationController?.pushViewController(jsAndOCInteVC, animated: true)
        
    }
    
    func JumpToJSExportVC()
    {
        let jsExportVC = JSExportVC()
        
        navigationController?.pushViewController(jsExportVC, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cellID = "cell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        
        if cell == nil {
            
            cell = UITableViewCell.init(style: .default, reuseIdentifier: cellID)
        }
        
        cell?.textLabel?.text = dataSource[indexPath.row] 
        
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             
        switch indexPath.row {
            
        case 0: //WebView的拦截交互
            
            JumpToJSAndOCInterceptVC()
            
            break
            
        case 1: //JSCore交互
            
            JumpToJSCoreVC()
            
            break
            
        default://语言穿梭机协议(JSExport)
            
            JumpToJSExportVC()
            
            break
        }
        
    }
    

}


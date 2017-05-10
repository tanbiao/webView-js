//
//  JSAndOCInterceptVC.swift
//  JS 与 Swift 交互
//
//  Created by 谭彪 on 16/9/28.
//  Copyright © 2016年 QuanQuan. All rights reserved.
//

import UIKit

class JSAndOCInterceptVC: UIViewController,UIWebViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       title = "WebView的拦截交互"
        
       setupInit()
    }
    
    func setupInit()
    {
        webView.delegate = self
        let url = Bundle.main.url(forResource: "test1.html", withExtension: nil)
        let request = URLRequest.init(url: url!)
        webView.loadRequest(request)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if ((request.url?.absoluteString) != nil)
        {
            let scheme = request.url?.scheme
            
            if scheme! == "choseimage"
            {
                //弹出相册
                showImagePicker()
                
                //表示不跳转那个协议
                return false
            }
        }
        
        return true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
       title = self.webView.stringByEvaluatingJavaScript(from: "document.title")
    }
    
    func showImagePicker()
    {
        let imagePicker = UIImagePickerController.init()
        imagePicker.delegate = self
        
        self.present(imagePicker, animated: true, completion: nil)
               
    }
    
    //MARk:===UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let cachPath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last
        
        let filePath = cachPath! + "/testImage.png"
        let imageData = UIImagePNGRepresentation(selectedImage)
        
        guard let data = imageData else {
            
            let exp = NSException.init(name: NSExceptionName(rawValue: "图片异常"), reason: "图片转NSData出问题了", userInfo: nil)
            exp.raise()
            
            return
        }
        //把选取的图片以二进制 存在沙盒里面
        try! data.write(to: URL(fileURLWithPath: filePath), options: .atomicWrite)
        picker.dismiss(animated: true, completion: nil)
        
        //执行JS方法
        evaluatJSFunc(filePath as NSString)
    }
    
    //执行JS方法
    func evaluatJSFunc(_ filePath : NSString)
    {
        let jsFunc = "showImage('\(filePath)')"
        
        self.webView.stringByEvaluatingJavaScript(from: jsFunc)
        
    }
   
}

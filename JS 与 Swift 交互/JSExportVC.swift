//
//  JSExportVC.swift
//  JS 与 Swift 交互
//
//  Created by 谭彪 on 16/9/28.
//  Copyright © 2016年 QuanQuan. All rights reserved.
//

import UIKit
import JavaScriptCore

//注意这里必须加上 @ObjC 不加@ObjC 是没得效果的
@objc protocol SwiftJSDelegate : JSExport {
    
    func getStrWithJS(_ str : NSString)
    
    func jsCallObjcAndObjcCallJsWithDict(_ dict: [String : AnyObject])
    
}

class JSExportVC: UIViewController,UIWebViewDelegate ,SwiftJSDelegate{
    
    @IBOutlet var webView: UIWebView!
    
    var context : JSContext  = JSContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()

         title = "语言穿梭机协议(JSExport)"
         setupInit()
    }
    
    func setupInit()
    {
        webView.delegate = self
        let url = Bundle.main.url(forResource: "test1.html", withExtension: nil)
        let request = URLRequest.init(url: url!)
        webView.loadRequest(request)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
      self.context = self.webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
 //1.这种方式是在本类中调用协议的方法
 
//     context.setObject(self, forKeyedSubscript: "SwiftContext")
  
    //2.也可以注入模型
      let model = JSSwiftModel()
      model.context = context
      //注入模型
      context.setObject(model, forKeyedSubscript:"SwiftModel" as (NSCopying & NSObjectProtocol)!)
        
      context.exceptionHandler = {
        value , excepton in
          print( excepton)
        
        }
        
    }
    
    //MARK:SwiftJSDelegate
    func getStrWithJS(_ str: NSString) {
        
        print("str =============\(str)")
                
        let values = JSContext.currentArguments()
        
        for value in values! {
            
            print(value)
        }
    }
    
    
    func jsCallObjcAndObjcCallJsWithDict(_ dict: [String : AnyObject])
    {
        print(dict)
        
    }
    
}

 class JSSwiftModel: NSObject ,SwiftJSDelegate
{
    var vc : JSExportVC?

    var context : JSContext?

    func getStrWithJS(_ str: NSString)
    {
        print("str =============\(str)")
        
       //这里可以调用JS的方法
//       let jsFunc = context?.objectForKeyedSubscript("contextBtnClick")
//       
//       jsFunc?.callWithArguments([])
        
//       let jsFunc = context?.evaluateScript("contextBtnClick")
//       jsFunc?.callWithArguments([])
        
    }

    func jsCallObjcAndObjcCallJsWithDict(_ dict: [String : AnyObject])
    {
        print(dict)
    }
    
}



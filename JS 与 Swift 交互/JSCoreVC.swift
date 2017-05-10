//
//  JSCoreVC.swift
//  JS 与 Swift 交互
//
//  Created by 谭彪 on 16/9/28.
//  Copyright © 2016年 QuanQuan. All rights reserved.
//

import UIKit
import JavaScriptCore

class JSCoreVC: UIViewController,UIWebViewDelegate {
        
    @IBOutlet weak var webView: UIWebView!
    
    var context : JSContext {
        
        let ctx = self.webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext
        
        ctx.exceptionHandler = {
        
            ctx , value in
            
            print(value)
        }
        
        return ctx
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "JSCore交互"
        
        setupInit()
        
    }
    
    func setupInit()
    {
        webView.delegate = self
        
        let url = Bundle.main.url(forResource: "test1.html", withExtension: nil)
        let request = URLRequest.init(url: url!)
        webView.loadRequest(request)
    }
    
    //MARK:======UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView)
    {
        //执行JS方法,直接调用
        evaluatJSFunc()
        
        //点击回调
        evaluatJSFunc1()
        
        //JS 给Swift 回调传参数
        evaluatJSFunc2()
    }
    
    func evaluatJSFunc()
    {
        let jsfunc = context.objectForKeyedSubscript("contextBtnClick")
        
        jsfunc?.call(withArguments: [])
    }
    
    //JS 点击按钮的回调
    func evaluatJSFunc1()
    {
        let JSCallBack : @convention(block) () -> () = {
            
            print("按钮点击回调成功")
        }
        
        self.context.setObject(unsafeBitCast(JSCallBack, to: AnyObject.self), forKeyedSubscript: "JSCallBack" as (NSCopying & NSObjectProtocol)!)
    }
    
    //JS 给swift 传参数
    func evaluatJSFunc2()
    {
        let JSCallBack: @convention(block) ()->() = {
            
            let values = JSContext.currentArguments()
            
            //value 是JSValue 类型 要用参数 需要转
            for value in values! {
                
                print("参数:=============\(value)")
            }
        }
        
        self.context.setObject(unsafeBitCast(JSCallBack, to: AnyObject.self), forKeyedSubscript: "JSCallBackWithArgument" as (NSCopying & NSObjectProtocol)!)
    }
    
}

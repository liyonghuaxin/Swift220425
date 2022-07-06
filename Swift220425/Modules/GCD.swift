//
//  GCD.swift
//  Swift220425
//
//  Created by issuser on 2022/5/9.
//

import Foundation
import UIKit

class GCDTest: UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        
        //回到主线程
        DispatchQueue.global().async {
            DispatchQueue.main.async {
//                print("回到主线程\(Thread.current)")
            }
        }
        
        /*
         创建队列
         QoS：标注每个通信的priority
         attributes：concurrent代表并发
         */
        //串行
        let serialQueue = DispatchQueue(label: "SerialOne")
        //并行
        let concurrentQueue = DispatchQueue(label: "ConcurrentOne", attributes: .concurrent)
        //其它参数
        let queue = DispatchQueue.init(label: "label", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        queue.async(group: nil, qos: .background, flags: .inheritQoS) {
            
        }
        
        /*
         延时
         */
        var workItem = DispatchWorkItem.init {
            
        }
        workItem = DispatchWorkItem(qos: .default, flags: .barrier, block: {
            
        })
        let deadline = DispatchTime.now() + 5.0
        DispatchQueue.global().asyncAfter(deadline: deadline, execute: workItem)
        DispatchQueue.global().asyncAfter(deadline: deadline) {
            
        }
        DispatchQueue.main.asyncAfter(deadline: deadline, execute: workItem)
//        workItem.cancel()
        

        
        
        //DispatchGroup
        let group = DispatchGroup()
        group.enter()
//        self.sendHTTPRequest1(params:[String: Any]) {
//            print("request complete")
//            group.leave()
//        }
//        group.enter()
//        self.sendHTTPRequest1(params:[String: Any]) {
//            print("request complete")
//            group.leave()
//        }
        group.notify(queue: DispatchQueue.main) {
            
        }
        
        //Semaphore
        let semaphore = DispatchSemaphore(value: 2)
        let semaphoreQueue = DispatchQueue.global()
        semaphoreQueue.async {
            semaphore.wait()
            self.sendHTTPRequest(params:["123": 123]) {
                semaphore.signal()
            }
        }
        
        semaphoreQueue.async {
            semaphore.wait()
            self.sendHTTPRequest(params: ["123": 123]) {
                semaphore.signal()
            }
        }
        
        semaphoreQueue.async {
            semaphore.wait()
            self.sendHTTPRequest(params: ["123": 123]) {
                semaphore.signal()
            }
            
        }
        
        /*
         Barrier
         */
        let barrierQueue = DispatchQueue(label: "barrier", attributes: .concurrent)
        barrierQueue.async {
            self.sendHTTPRequest(params: ["123":123]) {
                print("A")
            }
        }
        
        barrierQueue.async {
            self.sendHTTPRequest(params: ["123":123]) {
                print("A1")
            }
        }
        
        barrierQueue.async {
            self.sendHTTPRequest(params: ["123":123]) {
                print("A2")
            }
        }
        
        
        barrierQueue.async(flags: .barrier) {
            self.sendHTTPRequest(params: ["123":456]) {
                print("barrier")
            }
        }
            
        barrierQueue.async {
            self.sendHTTPRequest(params: ["123":123]) {
                print("B")
            }
        }
        
        /*
         网络请求并发+并发
         group + semaphore
         */
        let testQueue = DispatchQueue.global()
        let testGroup = DispatchGroup()
        let testSemaphore = DispatchSemaphore(value: 0)
        testQueue.async(group: testGroup) {
            //头像
//            FileProcessingViewModel().uploadDoctorAuthHeaderImg(headImg, type: .headdoctor) { (status) in
//                if status {
//                    testSemaphore.signal()
//                }
//            }
        }
        
        testQueue.async(group: testGroup) {
            //资格证书
//                FileProcessingViewModel().uploadImagesToQualification(self.imagesView.images!, finish: { (value) in
//                    testSemaphore.signal()
//                })
        }
        
        testGroup.notify(queue: testQueue) {
            testSemaphore.wait()
            testSemaphore.wait()
            //注册认证
        }
        
    }
    
    //网络请求
    func sendHTTPRequest(params: [NSString: Any], exe: () -> ()) {
        exe()
    }
    
}

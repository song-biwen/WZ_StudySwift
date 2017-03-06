//
//  ViewController.swift
//  StudySwift
//
//  Created by songbiwen on 2017/2/6.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

import UIKit

enum Week {
    case Mon,Tue,Wed,Thi,Fri,Sat,Sun;
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView?
    
    var dataSource:Array<String>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(Week.Wed.hashValue);
        
        dataSource = ["URLConnectionController","SimplePlayerController",
                      "SignViewController","MapViewController",
                        ];
        
        setupUI();
        
        var str:String!;
        str = "123";
        print("int ...   \(Int(str))");
        
        if Int(str) == 123 {
            print("/////    Sucess");
        }
        
        //闭包
        function0 { (a:Int) -> Int in
            return a;
        }
        
        for index in 1...5 {
            print("\(index) index is \(index)")
        }
        
        //for循环变量字典数组
        let userInfo = ["name":"songbiwen","age":"27","height":"162","weight":"120"];
        for key in userInfo {
            print("user \(key.key) is \(key.value)");
        }
        
    }

    
    
    
    //闭包
    func function0(closure:(Int)->Int) {
        let result = closure(0);
        print(result);
    }
    
    func setupUI() {
        
        var frame = self.view.bounds;
        tableView = UITableView(frame: frame, style: UITableViewStyle.plain);
        tableView?.delegate = self;
        tableView?.dataSource = self;
        self.view.addSubview(tableView!);
        
        tableView?.reloadData();
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataSource?.count)!;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell");
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell");
        }
        cell?.textLabel?.text = dataSource?[indexPath.row];
        return cell!;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: false);
        
        // 1.获取命名空间
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            print("命名空间不存在")
            return
        }
        // 2.通过命名空间和类名转换成类
        let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + (dataSource?[indexPath.row])!)
        
        //注意，cls为空的原因是clsName里面含有数字
        
        
        // swift 中通过Class创建一个对象,必须告诉系统Class的类型
        guard let clsType = cls as? UIViewController.Type else {
            print("无法转换成UIViewController")
            return
        }
        
        // 3.通过Class创建对象
        let childController = clsType.init()
        self.navigationController?.pushViewController(childController, animated: true)
    }
}


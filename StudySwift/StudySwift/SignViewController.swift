//
//  SignViewController.swift
//  StudySwift
//
//  Created by songbiwen on 2017/2/13.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {

    var nameTextField:UITextField!;
    var names:Set<String>!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white;
        names = Set();
        setupUI();
        
    }
    
    //界面初始化
    func setupUI() {
        let nameLabel:UILabel = UILabel(frame:CGRect(x:20,y:60,width:60,height:40));
        nameLabel.text = "姓名";
        self.view.addSubview(nameLabel);
        
        nameTextField = UITextField(frame:CGRect(x:80,y:60,width:200,height:40));
        nameTextField.placeholder = "请输入您的姓名";
        self.view.addSubview(nameTextField);
        
        let signButton:UIButton = UIButton(frame:CGRect(x:20,y:120,width:40,height:40));
        signButton.setTitle("签到", for: UIControlState.normal);
        signButton.backgroundColor = UIColor.brown;
        signButton.addTarget(self, action: #selector(signButtonAction), for: UIControlEvents.touchUpInside);
        self.view.addSubview(signButton);
        
        let reviewButton:UIButton = UIButton(frame:CGRect(x:80,y:120,width:40,height:40));
        reviewButton.setTitle("查看", for: UIControlState.normal);
        reviewButton.backgroundColor = UIColor.brown;
        reviewButton.addTarget(self, action: #selector(reviewButtonAction), for: UIControlEvents.touchUpInside);
        self.view.addSubview(reviewButton);
        
    }
    
    func signButtonAction() {
        names.insert(nameTextField.text!);
        let alertView:UIAlertView! = UIAlertView(title: "签到成功", message: nil , delegate: nil, cancelButtonTitle: "确定");
        alertView.show();
    }

    func reviewButtonAction() {
        print(names);
    }
}

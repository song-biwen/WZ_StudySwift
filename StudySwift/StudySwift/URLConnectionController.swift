//
//  URLConnectionController.swift
//  StudySwift
//
//  Created by songbiwen on 2017/2/6.
//  Copyright © 2017年 songbiwen. All rights reserved.
//

import UIKit

//网络请求
class URLConnectionController: UIViewController {

    var picture:UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI();
        
        
        //设置背景颜色
        self.view.backgroundColor = UIColor.white;
        //设置导航栏标题
        self.title = "URLConnectionController";
        
        //下载图片http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg
        let url = NSURL(string:"http://pic35.nipic.com/20131121/2531170_145358633000_2.jpg");
        let request = NSURLRequest(url:url as! URL);
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue()) { (response, data, error) in
            print("\(response)");
            let httpResponse = response as! HTTPURLResponse;
            if httpResponse.statusCode == 200 {
                
                print("图片加载成功");
                
                //获取文件路径
                let docPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true);
                let imagePath = docPath.first! + "/1.jpg";
                print(imagePath);
                //将图片下载到本地
                var data1 = data as! NSData;
                data1.write(toFile: imagePath, atomically: true);
                
                self.picture?.image = UIImage(contentsOfFile:imagePath);
                
            }else {
                print("图片加载失败");
            }
        }
    }

    func setupUI() {
        picture = UIImageView(frame:CGRect(x: 100, y: 100, width: 100, height: 100));
        self.view.addSubview(picture!);
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

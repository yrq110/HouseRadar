# HouseRadar

一个通过地理位置和范围搜索租房信息的iOS应用。

## 开发环境
* iOS 9.2+
* Xcode 8.2
* Objective-C

## 功能
* **雷达搜索**-设定中心点与半径，搜索范围内的房源
* **条件搜索**-设定详细信息进行精确搜索
* **房源列表**-查看数据库中的房源
* **收藏**-收藏列表
* **对比**-对比列表
* **设置**-加载图片、夜间模式、清空收藏夹

> 纯代码布局，屏幕百分比方案适配。

## 第三方库
* [AFNetworking(网络库)](https://github.com/AFNetworking/AFNetworking)
* [AMap_SDK(高德地图SDK)](http://lbs.amap.com/)
* [SDWebImage(异步图片加载)](https://github.com/rs/SDWebImage)
* [QQButton(QQ弹性按钮)](https://github.com/ZhongTaoTian/QQBtn)
* [ZFProgressView(环形进度条)](https://github.com/WZF-Fei/ZFProgressView)
* [Reachability(网络状态监测)](https://developer.apple.com/library/ios/samplecode/Reachability/Listings/Reachability_Reachability_m.html)


## 相关项目与服务
爬虫将爬取到的房源信息存储到云数据库，API服务器与云数据库相连，app通过API服务器获取数据。

* [HR-spider(房源爬虫)](https://github.com/yrq110/HR-spider)
* [HR-server(API服务器)](https://github.com/yrq110/HR-server)
* [Mongo云数据库(mLab)](https://mlab.com/)

## 其他
感谢dixxxy所做的logo与启动界面，感谢Yepoch的规划。

## App截图

![](http://obilz4jlp.bkt.clouddn.com/radar-2.png)
![](http://obilz4jlp.bkt.clouddn.com/radar-3.png)
![](http://obilz4jlp.bkt.clouddn.com/radar-1.png)
![](http://obilz4jlp.bkt.clouddn.com/radar-4.png)
![](http://obilz4jlp.bkt.clouddn.com/radar-5.png)  

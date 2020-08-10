//
//  HostApiKeyManager.h
//  NiuTongSheClient
//
//  Created by hfk on 2019/12/23.
//  Copyright © 2019 XWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//MARK:地址相关

//MARK:接口

//Common
extern NSString *const Common_file_upload;//上传文件

//登陆
extern NSString *const Login_user_login;//登录

//首页
extern NSString *const Home_store_storelist;//商家列表
extern NSString *const Home_main_recommend;//首页推荐商品列表
extern NSString *const Home_main_base;//首页基础信息(轮播图)
extern NSString *const Home_main_goods;//首页列表商品信息
extern NSString *const Home_main_goodDetail;//获取商品详情信息
extern NSString *const Home_message_messageList;//获取消息列表
extern NSString *const Home_message_allRead;//全部消息设为已读
extern NSString *const Home_message_new;//是否有未读消息
extern NSString *const Home_message_read;//消息设为已读


//购物车
extern NSString *const Car_main_carList;//刷新购物车列表    
extern NSString *const Car_order_tableList;//获取可预约餐桌
extern NSString *const Car_order_userOrder;//用户下单
extern NSString *const Car_order_butlerOrder;//管家下单
extern NSString *const Car_order_getBuildingNumber;//获取楼号
extern NSString *const Car_order_floorList;//获取楼层
extern NSString *const Car_order_room;//获取房间
extern NSString *const Car_order_allRoom;//获取所有房间
extern NSString *const Car_order_serviceRoom;//获取服务的房间
extern NSString *const Car_order_allMembers;//获取所有会员
extern NSString *const Car_order_serviceMember;//获取服务的会员

//我的
extern NSString *const Mine_user_Info;//获取用户信息
extern NSString *const Mine_butler_Info;//获取管家信息
extern NSString *const Mine_user_money;//获取用户余额
extern NSString *const Mine_user_editInfo;//修改用户信息
extern NSString *const Mine_user_consumptionType;//获取消费类型
extern NSString *const Mine_user_pay;//用户支付
extern NSString *const Mine_user_billingDetails;//余额流水
extern NSString *const Mine_user_orderSubscribe;//我的预约单(用户)
extern NSString *const Mine_user_orderSend;//我的送货上门(用户)
extern NSString *const Mine_butler_orderSubscribe;//我的预约单(管家)
extern NSString *const Mine_butler_orderSend;//我的送货上门(管家)
extern NSString *const Mine_order_cancelOrder;//取消订单
extern NSString *const Mine_order_evaluationOrder;//评价订单
extern NSString *const Mine_order_orderDetail;//订单详情
extern NSString *const Mine_order_orderPay;//订单已支付


@interface HostApiKeyManager : NSObject

////H5链接
//+ (NSString *)getH5ShareURL:(NSString *const) path;

@end

NS_ASSUME_NONNULL_END

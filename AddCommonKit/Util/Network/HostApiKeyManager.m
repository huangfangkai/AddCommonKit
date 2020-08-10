//
//  HostApiKeyManager.m
//  NiuTongSheClient
//
//  Created by hfk on 2019/12/23.
//  Copyright © 2019 XWQ. All rights reserved.
//

#import "HostApiKeyManager.h"
//MARK:地址相关
//MARK:接口
//Common
NSString *const Common_file_upload = @"common/file/upload";//上传文件

//登陆
NSString *const Login_user_login = @"app/login";

//首页
NSString *const Home_store_storelist = @"app/store/storeList";//商家列表
NSString *const Home_main_recommend = @"app/main/recommend";//首页推荐商品列表
NSString *const Home_main_base = @"app/main/base";//首页基础信息(轮播图)
NSString *const Home_main_goods = @"app/main/goods";//首页列表商品信息
NSString *const Home_main_goodDetail = @"app/main/goodDetail";//获取商品详情信息
NSString *const Home_message_messageList = @"app/message/list";//获取消息列表
NSString *const Home_message_allRead = @"app/message/allRead";//全部消息设为已读
NSString *const Home_message_new = @"app/message/new";//是否有未读消息
NSString *const Home_message_read = @"app/message/read";//消息设为已读



//购物车
NSString *const Car_main_carList = @"app/cart/list";//刷新购物车列表
NSString *const Car_order_tableList = @"app/table";//获取可预约餐桌
NSString *const Car_order_userOrder = @"app/user/order";//用户下单
NSString *const Car_order_butlerOrder = @"app/butler/order";//管家下单
NSString *const Car_order_getBuildingNumber = @"app/getBuildingNumber";//获取楼号
NSString *const Car_order_floorList = @"app/floorList";//获取楼层
NSString *const Car_order_room = @"app/room";//获取房间
NSString *const Car_order_allRoom = @"app/allRoom";//获取所有房间
NSString *const Car_order_serviceRoom = @"app/butlerServiceRoom";//获取服务的房间
NSString *const Car_order_allMembers = @"app/allMembers";//获取所有会员
NSString *const Car_order_serviceMember = @"app/serveMember";//获取服务的会员

//我的
NSString *const Mine_user_Info = @"app/user/info";//获取用户信息
NSString *const Mine_butler_Info = @"app/user/butlerDetail";//获取管家信息
NSString *const Mine_user_money = @"app/user/money";//获取用户余额
NSString *const Mine_user_editInfo = @"app/user/editInfo";//修改用户信息
NSString *const Mine_user_consumptionType = @"app/consumptionType";//获取消费类型
NSString *const Mine_user_pay = @"app/user/pay";//用户支付
NSString *const Mine_user_billingDetails = @"app/user/billingDetails";//余额流水
NSString *const Mine_user_orderSubscribe = @"app/user/orderSubscribe";//我的预约单(用户)
NSString *const Mine_user_orderSend = @"app/user/orderSend";//我的送货上门(用户)
NSString *const Mine_butler_orderSubscribe = @"app/butler/orderSubscribe";//我的预约单(管家)
NSString *const Mine_butler_orderSend = @"app/butler/orderSend";//我的送货上门(管家)
NSString *const Mine_order_cancelOrder = @"app/cancelOrder";//取消订单
NSString *const Mine_order_evaluationOrder = @"app/evaluationOrder";//评价订单
NSString *const Mine_order_orderDetail = @"app/user/orderDetail";//订单详情
NSString *const Mine_order_orderPay = @"app/orderPay";//订单已支付




@implementation HostApiKeyManager

//+ (NSString *)getH5ShareURL:(NSString *const) path{
//    return [[NSObject h5URLStr] stringByAppendingString:[NSString stringWithFormat:@"share.html?id=%@",path]];
//}
@end

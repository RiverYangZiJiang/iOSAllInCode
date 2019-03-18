//
//  MLMacro.h
//  Mateline
//
//  Created by sprite on 16/12/12.
//
//  存放一些公共的宏，如果非公共的，请在对应类定义，不要在此定义；如某一类宏比较多，建议放在单独的宏文件中，如MLMacroColor存放颜色相关的宏、MLMacroView存放和视图相关的宏；字符串建议用常量，不要用宏，以方便注释；

#import <Foundation/Foundation.h>
#import "MLMacroColor.h"
#import "MLMacroView.h"
#import "MLMarcoFont.h"

#pragma mark - 环信IM和推送 注：以下宏一次只能使用一个，不能同时使用
// 支持环信IM功能，工单消息使用环信推送
#define MLSupportEaseIM
// 无环信IM功能，工单消息使用环信推送 注：国内私有云局点使用该配置
//#define MLNoEaseIMUseEasePush
// 无IM功能，工单消息使用Google Firebase云消息推送
//#define MLNoIMUseFCM

#pragma mark - 私有云

//SSO对接标志位，表示SSO是否对接第三方SSO和会话管理
//1.公有云:使用OWS自己的SSO和会话管理
//2.私有云:主线版本使用CloudSop的SSO，陕西移动有两种认证：(1)OWS自己的SSO,(2)陕西移动4A认证
//3.主线版本使用
//#define UseThirdPartySSO

//陕西移动私有云4A使用
//#define Shanxicmcc_4A

// 私有版本标志位，私有云环境请不要注释本代码，私有云打开此标志位
//#define Channel_PrivateCloud

#pragma mark - 开发版本
// 开发版本
#define Development
// 给测试用的版本，即发布到蒲公英上的版本
//#define Test
// 发布到App Store上的版本
//#define AppStore

#pragma mark - BuglyAPPID & EaseMobAPNsCertName
/**
 *  1. 设置 Bugly 的 Appkey
 *  2. 设置推送证书的名字，正式环境为 production_apns，测试环境为 development_apns。具体证书的名字请登录环信后台查询
 */
#if defined(AppStore)
#define BuglyAPPID              @"0ca52cde0e"
#define EaseMobAPNsCertName     @"production_apns"
#define ML_CATCH_EXCEPTION(exception, name) MLDDLogError(@"捕获异常：%@", exception); [BuglyManager reportErrorName:name exception:exception];
#elif defined(Test)
#define BuglyAPPID              @"615d1df010"
#define EaseMobAPNsCertName     @"development_apns"
#define ML_CATCH_EXCEPTION(exception, name) MLDDLogError(@"捕获异常：%@", exception); [BuglyManager reportErrorName:name exception:exception];
#else
#define BuglyAPPID              @"c19cff5558"
#define EaseMobAPNsCertName     @"development_apns"
#define ML_CATCH_EXCEPTION(exception, type) @throw exception;
#endif


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define PERFORM_SAFE_BLOCK(block, ...) (block) ? block(__VA_ARGS__) : nil

// GCD
#define async_queue_block(queue, block, ...)            \
dispatch_async(queue, ^{                                \
PERFORM_SAFE_BLOCK(block, ##__VA_ARGS__);               \
});

#define async_main_queue_block(block, ...) async_queue_block(dispatch_get_main_queue(), block, ##__VA_ARGS__)

// 多语言操作
#define GET_LANGUAGE_KEY(str)    ([[BCLanguages sharedInstance]getKeyValue:str withValue:@""])
#define _LS(str)                ([[BCLanguages sharedInstance]getKeyValue:str withValue:@""])

#define IOS7    (fabs( (double)[[UIDevice currentDevice].systemVersion doubleValue])>=7.0f) //判定系统版本
#define IOS8UP ([[UIDevice currentDevice].systemVersion floatValue] >= 8)
#define IOS11Less ([[UIDevice currentDevice].systemVersion floatValue] < 11)

// 定义常量
#define DECLARE_KEY(key)                            FOUNDATION_EXPORT NSString *const key;
#define DEFINE_KEY(key)                             NSString *const key = @ #key;
#define DEFINE_KEY_AND_VALUE(key, value)             NSString *const key = value;

// 通过图片名来构建图片
#define IMAGE_BY_NAME(name) [UIImage imageNamed:name]

#define isEqualIndexPath(indexPath, SECTION, ROW) (indexPath.section == SECTION) && (indexPath.row == ROW)

#define StringFromClass(CLASS) NSStringFromClass([CLASS class])

// 获取头像
#define LOAD_PORTRAIT(imageView, avatarString) LOAD_PORTRAIT_DEDAULTIMAGE(imageView, avatarString, IMAGE_BY_NAME(@"avatar_unknow"))
#define LOAD_PORTRAIT_DEDAULTIMAGE(imageView, avatarString, defaultImage) [imageView sd_setImageWithURL:[NSURL URLWithString:avatarString] placeholderImage:defaultImage options:SDWebImageHandleCookies|SDWebImageAllowInvalidSSLCertificates];

// 单例的头文件和实现文件宏定义
#define SINGLETON_INTERFACE(name)   + (instancetype)shared##name;
#define SINGLETON_IMPLEMENTATION(name)              \
static id shared##name = nil;                       \
+ (instancetype)shared##name {                      \
static dispatch_once_t onceToken;                   \
dispatch_once(&onceToken, ^{                        \
shared##name = [[self alloc] init];                 \
});                                                 \
\
return shared##name;                                \
}

/** 弱引用 */
#define MLWeakSelf(type)  __weak __typeof(type) weak##type = type;
/** 强引用 */
#define MLStrongSelf(type)  __strong __typeof(type) type = weak##type;

/** 角度转弧度 */
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

/** 获取登录账号的userID */
#define GET_MINE_USERID [AppCache sharedInstance].loginResult.userId
/** 获取登录账号的用名 */
#define GET_MINE_USERNAME [AppCache sharedInstance].loginResult.loginUserName
/** 获取登录账号的用全名 */
#define GET_MINE_USER_FULL_NAME [AppCache sharedInstance].loginResult.username



#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFHTTPRequestOperation.h"
typedef NS_ENUM(NSInteger, HTTPStyle){
    HTTP,
    JSON,
    XML
};

typedef NS_ENUM(NSInteger, RequsetBodyStyle){
    BodyHttp,
    BodyJSON
};
@interface AFNTool : NSObject
/**
 *  网络请求get
 *
 *  @param url     请求url
 *  @param body    网络请求携带的Body
 *  @param style   请求返回的数据的格式
 *  @param success 成功调用的Block
 *  @param failure 失败调用的Block
 */
+ (void)get:(NSString *)url Body:(id)body HttpResult:(HTTPStyle)style success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;
/**
 *  网络请求post
 *
 *  @param url       请求url
 *  @param body      网络请求携带的Body
 *  @param style     请求返回的数据的格式
 *  @param bodyStyle 请求返回的数据的格式
 *  @param cookies       请求头
 *  @param success   成功调用的Block
 *  @param failure   失败调用的Block
 */
+ (void)post:(NSString *)url Body:(id)body HttpResult:(HTTPStyle)style RequsetBodyStyle:(RequsetBodyStyle)bodyStyle httpRequset:(NSDictionary *)cookies success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString *)url Body:(id)body success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)login:(NSString *)url Body:(id)body success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)getImageUrlData:(UIImage *)image success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

+ (void)getSBJson:(NSString *)url Data:(NSData *)data success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;


+ (void)getSBJsonAndImageStr:(NSString *)url Data:(NSData *)data Array:(NSMutableArray *)array success:(void(^)(NSDictionary *SBJson, NSString *imageStr ))success failure:(void(^)(NSError *error))failure;

+ (void)getImagesUrlWithImages:(NSArray *)imageArray success:(void(^)(id result))success failure:(void(^)(NSError *error))failure;

/**开启网络检测**/
+ (void)openAFNetworkReachability;
//开启主界面请求网络
+ (void)monitorNetworkStatus:(void(^)(AFNetworkReachabilityStatus status))AFNetworkStatus;

@end

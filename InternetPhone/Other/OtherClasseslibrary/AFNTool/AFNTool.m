
#import "AFNTool.h"
#import "AFNetworking.h"
@implementation AFNTool
+ (void)get:(NSString *)url Body:(id)body HttpResult:(HTTPStyle)style success:(void(^)(id result))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    
    switch (style) {
        case HTTP:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case JSON:
            break;
        case XML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    [manager GET:url parameters:body success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);

        }
        
    }];
    
}
+ (void)post:(NSString *)url Body:(id)body success:(void(^)(id result))success failure:(void(^)(NSError *error))failure{
    [self post:url Body:body HttpResult:JSON RequsetBodyStyle:BodyHttp httpRequset:nil success:success failure:failure];
}
+ (void)post:(NSString *)url Body:(id)body HttpResult:(HTTPStyle)style RequsetBodyStyle:(RequsetBodyStyle)bodyStyle httpRequset:(NSDictionary *)cookies success:(void(^)(id result))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];

    if (cookies) {
        for (NSString *key in cookies.allKeys) {
            [manager.requestSerializer setValue:cookies[key] forHTTPHeaderField:key];
        }
    }
    switch (style) {
        case HTTP:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case JSON:
            break;
        case XML    :
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
            break;
        default:
            break;
    }
    switch (bodyStyle) {
        case BodyHttp:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case BodyJSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        default:
            break;
    }
    [manager POST:url parameters:body success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
//        {"success":false,"data":{"error":"user token invalid"}}
        if ([responseObject[@"success"] boolValue] == NO) {
            
            if ([responseObject[@"errorcode"] integerValue] == 401) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"userTokenInvalidNotification" object:nil];
            }else{
                success(responseObject);
            }
        }else{
           success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (operation.response.statusCode == 401) {
//            
//        }
        if (failure) {
            failure(error);
        }
        
    }];
}
+ (void)login:(NSString *)url Body:(id)body success:(void(^)(id result))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    [manager POST:url parameters:body success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            NSString *userName = [dic objectForKey:@"name"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:userName forKey:@"userName"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if (failure) {
            failure(error);

        }
        
    }];
}
+ (void)getImageUrlData:(UIImage *)image success:(void(^)(id result))success failure:(void(^)(NSError *error))failure
{
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    NSDictionary *dic = [NSMutableDictionary dictionary];
    NSUserDefaults *tokendic = [NSUserDefaults standardUserDefaults];
    NSString *token = [tokendic objectForKey:@"token"];
    [dic setValue:token forKey:@"token"];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    NSString*urlStr = @"http://app.vshowbao.com/api/file/upload?";
    [manager POST:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd-hh:mm:ss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
        [formData appendPartWithFileData:data name:@"uploadedfile" fileName:fileName mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    #pragma clang diagnostic pop
}
+ (void)getSBJson:(NSString *)url Data:(NSData *)data success:(void(^)(id result))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *objec1 = @{@"cloudFolderId":@11001};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [manager POST:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:objec1 constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd-hh:mm:ss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:data name:@"filedata" fileName:fileName mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
//            NSString *strKey = [NSString stringWithFormat:@"%@",responseObject[@"files"][0][@"cloudFileId"]];
//            NSDictionary *dic = @{strKey:responseObject[@"files"][0][@"url"]};
//            NSArray *array = @[dic];
//            NSDictionary *dicBody = @{@"contentJson":[array JSONRepresentation]};
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);

        }
    }];
        #pragma clang diagnostic pop
}
+ (void)getSBJsonAndImageStr:(NSString *)url Data:(NSData *)data Array:(NSMutableArray *)array success:(void(^)(NSDictionary *SBJson, NSString *imageStr ))success failure:(void(^)(NSError *error))failure
{
    NSDictionary *objec1 = @{@"cloudFolderId":@11001};
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [manager POST:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:objec1 constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd-hh:mm:ss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        [formData appendPartWithFileData:data name:@"filedata" fileName:fileName mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            NSString *sortIndex = [NSString stringWithFormat:@"%ld",array.count];
            NSDictionary *dic =  @{@"id":@"0",
                                   @"image"      :responseObject[@"files"][0][@"url"],
                                   @"cloudFileId":responseObject[@"files"][0][@"cloudFileId"],
                                   @"content"    :@"",
                                   @"thumb"      :@"",
                                   @"isDelete"   :@"0",
                                   @"isNewObj"   :@"true",
                                   @"sortIndex"  :sortIndex};
            NSMutableDictionary *SBJson = [NSMutableDictionary dictionaryWithDictionary:dic];
            NSString *imageStr = [NSString stringWithFormat:@"%@%@",responseObject[@"files"][0][@"staticUrl"],responseObject[@"files"][0][@"url"]];
            success(SBJson,imageStr);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
            
        }
    }];
    #pragma clang diagnostic pop
}
+ (void)getImagesUrlWithImages:(NSArray *)imageArray success:(void(^)(id result))success failure:(void(^)(NSError *error))failure{
    
    [self getSmallImages:imageArray complite:^(NSArray *imageArray) {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [manager POST:@"http://image.panocooker.com/file/upload" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData){
            for (NSData *image in imageArray) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                formatter.dateFormat = @"yyyy-MM-dd-hh:mm:ss";
                NSString *str = [formatter stringFromDate:[NSDate date]];
                NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
                [formData appendPartWithFileData:image name:fileName fileName:fileName mimeType:@"image/png"];
            };
            
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success) {
                success(responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure) {
                failure(error);
                
            }
        }];
#pragma clang diagnostic pop
    }];
    
}
//网络检测
+ (void)openAFNetworkReachability {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];

    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        [MBProgressHUD showAFNErrorWithStatus:status];
    }];
    [manager startMonitoring];
}
//主界面重新请求接口
+ (void)monitorNetworkStatus:(void(^)(AFNetworkReachabilityStatus status))AFNetworkStatus {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (AFNetworkStatus) {
            AFNetworkStatus(status);
        }
    }];
    [manager startMonitoring];
}

+(void)getSmallImages:(NSArray *)imageArray complite:(void(^)(NSArray *imageArray))complite{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableArray *imageArr = [NSMutableArray array];
        for (UIImage *image in imageArray) {
            NSData *imageData = UIImagePNGRepresentation(image);
            NSData *upData;
            if (imageData.length > 500*1024) {
                upData = UIImageJPEGRepresentation(image, 0.4);
            }else{
                upData = imageData;
            }
            [imageArr addObject:upData];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complite)complite(imageArr);
                });
    });

}
@end

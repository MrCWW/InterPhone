//
//  CoreDataAPI.m
//  CoreDataDemo
//
//  Created by DUC-apple3 on 2017/9/1.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//
/**
 *  知识点：
 NSManagedObject：
 通过Core Data从数据库中取出的对象,默认情况下都是NSManagedObject对象.
 NSManagedObject的工作模式有点类似于NSDictionary对象,通过键-值对来存取所有的实体属性.
 setValue:forkey:存储属性值(属性名为key);
 valueForKey:获取属性值(属性名为key).
 每个NSManagedObject都知道自己属于哪个NSManagedObjectContext
 
 NSManagedObjectContext:
 负责数据和应用库之间的交互(CRUD，即增删改查、保存等接口都在这个对象中).
 所有的NSManagedObject都存在于NSManagedObjectContext中，所以对象和context是相关联的
 每个 context 和其他 context 都是完全独立的
 每个NSManagedObjectContext都知道自己管理着哪些NSManagedObject
 
 NSPersistentStoreCoordinator:
 添加持久化存储库，CoreData的存储类型（比如SQLite数据库就是其中一种）
 中间审查者，用来将对象图管理部分和持久化部分捆绑在一起，负责相互之间的交流（中介一样）
 
 NSManagedObjectModel:
 Core Data的模型文件
 
 NSEntityDescription：
 用来描述实体：相当于数据库表中一组数据描述
 */


#import "CoreDataAPI.h"
#define PhoneRecoredMark @"PhoneRecored"
@interface CoreDataAPI()

@end
@implementation CoreDataAPI
// 插入数据
+(BOOL)insertPhoneRecored:(PhoneRecoredModel *)phoneModel{
  PhoneRecored *Insertperson=[NSEntityDescription insertNewObjectForEntityForName:PhoneRecoredMark inManagedObjectContext:kCoreDataContext];
    Insertperson.name=phoneModel.name;
    
    Insertperson.phone=phoneModel.phone;
    
    Insertperson.updatedate=phoneModel.updatedate;
    
    Insertperson.timedate=phoneModel.timedate;
    //保存, 将插入操作更新到数据库
    NSError *error;
    [kCoreDataContext save:&error];
    
    if (error == nil) {
        NSLog(@"插入数据成功");
        return YES;
    }
    NSLog(@"插入数据失败");
    return NO;

}
//查询通话记录
+(NSArray *)searchPhoneRecored {
    //创建查询请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PhoneRecoredMark];
     NSError *error;
    NSArray *arr = [kCoreDataContext executeFetchRequest:request error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    //查询结果 赋给对象
    for (PhoneRecored *info in arr) {
        PhoneRecoredModel *model = [[PhoneRecoredModel alloc] init];
        model.name = info.name;
        model.phone = info.phone;
        model.updatedate = info.updatedate;
        model.timedate = info.timedate;
        [resultArray addObject:model];
    }
    
//    return resultArray;
   
    if (error == nil) {
        return resultArray;
    }
    return nil;
    

}
/**根据手机号查询通话记录*/
+ (NSArray *)searchWithPerson:(PhoneRecoredModel *)phoneModel{
    //创建查询请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PhoneRecoredMark];
    //按更新时间排列
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"updatedate" ascending:YES];
    
    NSArray *sortDescriptors=[NSArray arrayWithObject:sort];
    [request setSortDescriptors:sortDescriptors];
    //根据手机号查询
    request.predicate=[NSPredicate predicateWithFormat:@"phone=%@",phoneModel.phone];
    NSError *error;
    NSArray *arr = [kCoreDataContext executeFetchRequest:request error:&error];
    NSMutableArray *resultArray = [NSMutableArray array];
    //查询结果 赋给对象
    for (PhoneRecored *info in arr) {
        PhoneRecoredModel *model = [[PhoneRecoredModel alloc] init];
        model.name = info.name;
        model.phone = info.phone;
        model.updatedate = info.updatedate;
        model.timedate = info.timedate;
        [resultArray addObject:model];
    }
    
    return resultArray;
    
    if (error == nil) {
        return resultArray;
    }
    return nil;


}

//根据日期和电话号删除数据
+ (void)deleteWithPerson:(PhoneRecoredModel *)phoneModel{
    //创建查询请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PhoneRecoredMark];
    //根据日期和电话号
    request.predicate=[NSPredicate predicateWithFormat:@"timedate=%@ AND phone=%@",phoneModel.timedate,phoneModel.phone];
    NSError *error;
    NSArray *arr = [kCoreDataContext executeFetchRequest:request error:&error];
    //错误信息不存在
    if (error == nil) {
        for (PhoneRecored *info in arr) {
            //删除数据
            [kCoreDataContext deleteObject:info];
        }
        //保存, 将删除操作更新到数据库中
        [kCoreDataContext save:nil];
        NSLog(@"删除指定数据成功");
    }else {
        NSLog(@"删除指定数据失败");
    }
}

//删除所有数据

+(void)deleteAllDatas
{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PhoneRecoredMark];
    
    NSArray *arr = [kCoreDataContext executeFetchRequest:request error:nil];
    
    for (PhoneRecored *info in arr) {
        //删除数据
        [kCoreDataContext deleteObject:info];
    }
    //保存, 将删除操作更新到数据库中
    [kCoreDataContext save:nil];
    
}
@end

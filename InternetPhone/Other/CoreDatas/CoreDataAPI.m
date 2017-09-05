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
#import "PhoneRecoredModelCount.h"
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
+(NSDictionary *)searchPhoneRecored {
    //创建查询请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PhoneRecoredMark];
    //按更新时间排列
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"updatedate" ascending:NO];
    
    NSArray *sortDescriptors=[NSArray arrayWithObject:sort];
    [request setSortDescriptors:sortDescriptors];
    
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
 NSDictionary *datadic = [self dataArr:resultArray];
    
    
   
    if (error == nil) {
        return datadic;
    }
    return nil;
    

}
/**根据手机号查询通话记录*/
+ (NSArray *)searchWithPerson:(PhoneRecoredModel *)phoneModel{
    //创建查询请求对象
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:PhoneRecoredMark];
    //按更新时间排列
    NSSortDescriptor *sort=[NSSortDescriptor sortDescriptorWithKey:@"updatedate" ascending:NO];
    
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
    
//    return resultArray;
    
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

+(NSDictionary *)dataArr:(NSArray *)resultArr{
 NSMutableArray *timeArr = [NSMutableArray array];//所有的日期
    for (PhoneRecoredModel *model in resultArr) {
        NSString *timeStr = model.timedate;
        if (![timeArr containsObject:timeStr]) {
            // 如果数组中不包含该日期，则添加进去
            [timeArr addObject:timeStr];
            
        }
    }
    //在时间轴数组中遍历数据库，是同一个时间的，则添加到一个数组中
    NSMutableArray *totalArr = [NSMutableArray array];
    for (NSString *timestr in timeArr) {
          NSMutableArray *timeSameArr = [NSMutableArray array];
        NSMutableArray *phoneArr = [NSMutableArray array];//同一个数组中的所有电话号码
        for (PhoneRecoredModel *model in resultArr) {
            NSString *timeModelStr = model.timedate;
            //如果时间轴的字符串等于model时间，则创建并添加model到同一个数组中
          
            if ([timestr isEqualToString:timeModelStr]) {
                [timeSameArr addObject:model];
                [phoneArr addObject:model.phone];
            }
        }
        //数组去重
      NSArray *phoneCountArr =  [self selectPhoneNum:phoneArr timeSameModelArr:timeSameArr];
        [totalArr addObject:phoneCountArr];
    }
    NSMutableDictionary *dicTotal = [[NSMutableDictionary alloc] init];
    [dicTotal setValue:timeArr forKey:@"timeArr"];
    [dicTotal setValue:totalArr forKey:@"totalArr"];
    return dicTotal;
}
//去除相同的电话号码，并且去重计数
+(NSArray *)selectPhoneNum:(NSMutableArray *)phoneArr timeSameModelArr:(NSMutableArray *)modelArr {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSMutableArray *array = phoneArr;
    NSSet *set = [NSSet setWithArray:array];
    
    for (NSString *setstring in set) {
        //需要去掉的元素数组
        NSMutableArray *filteredArray = [[NSMutableArray alloc]initWithObjects:setstring, nil];
        
        NSMutableArray *dataArray = array;
        
        NSPredicate * filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",filteredArray];
        //过滤数组
        NSArray * reslutFilteredArray = [dataArray filteredArrayUsingPredicate:filterPredicate];
      
        
        int number = (int)(dataArray.count-reslutFilteredArray.count);

        
        [dic setObject:[NSString stringWithFormat:@"%d",number] forKey:setstring];
    }
    // 去除数组中相同的多余电话号码
        NSMutableArray *listAry = [[NSMutableArray alloc]init];
    NSMutableArray *listmodelAry = [[NSMutableArray alloc]init];

    for (PhoneRecoredModel *model in modelArr) {
//        if (dicPhone[model.phone]==nil) {
//            [dicPhone setValue:model forKey:model.phone];
//        }
        //包含电话号码数组
        if (![listAry containsObject:model.phone]) {
            [listAry addObject:model.phone];
            // 最终无重复的phone数组
            [listmodelAry addObject:model];
        }
    }

   //无重复的数组根据获取的dic的电话个数，组成phoneRecoredModelCount;
    //创建phoneRecoredModelCount数组
    NSMutableArray *phoneRecoredModelCountArr = [NSMutableArray array];
    for (PhoneRecoredModel *model in listmodelAry) {
        PhoneRecoredModelCount *modelCount = [[PhoneRecoredModelCount alloc] init];
        NSString *count = dic[model.phone];//重复的电话个数
        modelCount.name = model.name;
        modelCount.phone = model.phone;
        modelCount.timedate = model.timedate;
        modelCount.updatedate = model.updatedate;
        modelCount.countPhone = count;
        modelCount.isShowDetial = YES;
        modelCount.isSelectDelete = NO;
        [phoneRecoredModelCountArr addObject:modelCount];//按照日期排序
    }
    
    return phoneRecoredModelCountArr;
}
@end

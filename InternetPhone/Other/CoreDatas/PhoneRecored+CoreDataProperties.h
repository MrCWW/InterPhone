//
//  PhoneRecored+CoreDataProperties.h
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/9/3.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "PhoneRecored+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface PhoneRecored (CoreDataProperties)

+ (NSFetchRequest<PhoneRecored *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *phone;
@property (nullable, nonatomic, copy) NSDate *updatedate;
@property (nullable, nonatomic, copy) NSString *timedate;

@end

NS_ASSUME_NONNULL_END

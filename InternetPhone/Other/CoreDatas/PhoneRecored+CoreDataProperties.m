//
//  PhoneRecored+CoreDataProperties.m
//  InternetPhone
//
//  Created by DUC-apple3 on 2017/9/3.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "PhoneRecored+CoreDataProperties.h"

@implementation PhoneRecored (CoreDataProperties)

+ (NSFetchRequest<PhoneRecored *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"PhoneRecored"];
}

@dynamic name;
@dynamic phone;
@dynamic updatedate;
@dynamic timedate;

@end

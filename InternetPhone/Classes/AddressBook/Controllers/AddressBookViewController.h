//
//  AddRessBookViewController.h
//  InternetPhone
//
//  Created by wangkun on 2017/8/8.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRessBookViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UISearchBar *mysearchbar;

@property(nonatomic,strong)NSMutableArray *cities;
@property(nonatomic,strong)NSMutableArray *filteredCities;
@property(nonatomic,strong)NSMutableArray *PHONE;

@property BOOL isFiltered;
@property(nonatomic,strong)UITableView *myTableView;

@end

//
//  AddRessBookViewController.m
//  InternetPhone
//
//  Created by wangkun on 2017/8/8.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "AddRessBookViewController.h"
#import <Contacts/Contacts.h>
#import "contTableViewCell.h"
#import <ContactsUI/ContactsUI.h>
#import "AddDetailViewController.h"
@interface AddRessBookViewController ()

@end

@implementation AddRessBookViewController
@synthesize cities;

- (void)viewDidLoad {
    [super viewDidLoad];

    cities = [[NSMutableArray alloc] init];
    _filteredCities = [[NSMutableArray alloc] init];
    _PHONE = [[NSMutableArray alloc] init];

    [self loadContactList];
    [self creatTableView];
 

}
-(void)creatTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth, ScreenHeight-180)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myTableView];
    //点击空白处收回键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

    
}
-(void)reloadContactList {
    [cities removeAllObjects];
    [_filteredCities removeAllObjects];
    [_PHONE removeAllObjects];
    [self loadContactList];
}
-(void)loadContactList {
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if( status == CNAuthorizationStatusDenied || status == CNAuthorizationStatusRestricted)
    {
        NSLog(@"access denied");
    }
    else
    {
        //Create repository objects contacts
        CNContactStore *contactStore = [[CNContactStore alloc] init];

        
        NSArray *keys = [[NSArray alloc]initWithObjects:CNContactIdentifierKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey, CNContactPhoneNumbersKey, CNContactViewController.descriptorForRequiredKeys, nil];
        
        // Create a request object
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
        request.predicate = nil;
        
        [contactStore enumerateContactsWithFetchRequest:request
                                                  error:nil
                                             usingBlock:^(CNContact* __nonnull contact, BOOL* __nonnull stop)
         {
             NSString *phoneNumber = @"";
             if( contact.phoneNumbers)
                 phoneNumber = [[[contact.phoneNumbers firstObject] value] stringValue];
             
             NSLog(@"phoneNumber = %@", phoneNumber);
             NSLog(@"givenName = %@", contact.givenName);
             NSLog(@"familyName = %@", contact.familyName);
             
             
             [cities addObject:contact];
         }];
        
        [_myTableView reloadData];
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_isFiltered == YES)
    {
        return [_filteredCities count];
    }
    else
    {
        return [cities count];
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    static NSString *cellIdentifer = @"cell";
    contTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    if(cell == nil)
    {
        cell = [[contTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        
    }
    
    if(_isFiltered == YES){
        cell.textLabel.text = [_filteredCities objectAtIndex:indexPath.row];

    }
    else{
        CNContact* contact = [cities objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
    }
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        iv.image = [UIImage imageNamed:@"5@3x20170720"];
        cell.imageView.image=iv.image;
        iv.layer.masksToBounds = YES;
    
        CGSize itemSize = CGSizeMake(30, 30);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [cell.imageView.image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if(searchText.length == 0)
    {
        _isFiltered = NO;
    }
    else
    {
        _isFiltered = YES;
        _filteredCities = [[NSMutableArray alloc]init];
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        NSArray *keys = [[NSArray alloc]initWithObjects:CNContactIdentifierKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey, CNContactPhoneNumbersKey, CNContactViewController.descriptorForRequiredKeys, nil];
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
        request.predicate = nil;
        
        [contactStore enumerateContactsWithFetchRequest:request
                                                  error:nil
                                             usingBlock:^(CNContact* __nonnull contact, BOOL* __nonnull stop)
         {
             NSString *phoneNumber = @"";
             if( contact.phoneNumbers)
                 phoneNumber = [[[contact.phoneNumbers firstObject] value] stringValue];
             
             NSLog(@"phoneNumber = %@", phoneNumber);
             NSLog(@"givenName = %@", contact.givenName);
             NSLog(@"familyName = %@", contact.familyName);
             
             NSString *phoneNumber1 = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
             NSArray* array = [phoneNumber1 componentsSeparatedByString:@";"];

             for(NSString *cityName in array)
             {
                 NSRange cityNameRange = [cityName rangeOfString:searchText options:NSCaseInsensitiveSearch];
                 
                 if(cityNameRange.location != NSNotFound)
                 {
                     [_filteredCities addObject:cityName];
                     [_PHONE addObject:phoneNumber];
                 }
             }
         }];
        
       
        
    }
    [_myTableView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(_isFiltered == YES)
    {
        AddDetailViewController *TsdVc = [[AddDetailViewController alloc]init];
        TsdVc.strname = [_filteredCities objectAtIndex:indexPath.row];
        TsdVc.strPhone = [_PHONE objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:TsdVc animated:YES];
        
    }
    else
    {
        AddDetailViewController *TsdVc = [[AddDetailViewController alloc]init];
        CNContact* contact = [cities objectAtIndex:indexPath.row];
        TsdVc.strname = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
        NSString *phoneNumber = @"";
        phoneNumber = [[[contact.phoneNumbers firstObject] value] stringValue];
        TsdVc.strPhone = phoneNumber;
        [self.navigationController pushViewController:TsdVc animated:YES];
    }
   
    
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_mysearchbar resignFirstResponder];
}

// 点击空白处收起键盘

-(void)keyboardHide:(UITapGestureRecognizer *)gestureRecognizer

{
    
    [self.view endEditing:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

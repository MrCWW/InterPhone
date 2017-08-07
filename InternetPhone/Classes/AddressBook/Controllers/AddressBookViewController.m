//
//  AddressBookViewController.m
//  InternetPhone
//
//  Created by wangkun on 2017/8/1.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "AddressBookViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>
#import "contTableViewCell.h"
#import "AddDetailViewController.h"
#import "PJSearchBar.h"
#import <UIKit/UIKit.h>
@interface AddressBookViewController ()<CNContactViewControllerDelegate, CNContactPickerDelegate, UITableViewDataSource, UITableViewDelegate,PJSearchBarDelegate>
@property(nonatomic,strong)UITableView *myTableView;
@property (nonatomic, strong) PJSearchBar *searchBar;      //搜索框
@property(nonatomic,strong)NSMutableArray *cities;
@property(nonatomic,strong)NSMutableArray *filteredCities;
@property BOOL isFiltered;
@property (nonatomic, retain) NSMutableArray *resultArr;   //搜索结果

@end

@implementation AddressBookViewController
@synthesize cities;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    cities = [[NSMutableArray alloc] init];
    [self loadContactList];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
    [self.myTableView registerNib:[UINib nibWithNibName:@"contTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    _searchBar = [[PJSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 40) placeholder:@"搜索"];
    _searchBar.delegate = self;
    _searchBar.barTintColor = [UIColor redColor];
    [self.view addSubview:_searchBar];
    //点击空白处收回键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];

}
-(void)reloadContactList {
    [cities removeAllObjects];
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
             NSLog(@"email = %@", contact.emailAddresses);
             
             
             [cities addObject:contact];
             
         }];
        
        [_myTableView reloadData];
    }
    
}

#pragma mark -
#pragma mark Contact Method

-(void)saveContact:(NSString*)familyName givenName:(NSString*)givenName phoneNumber:(NSString*)phoneNumber {
    CNMutableContact *mutableContact = [[CNMutableContact alloc] init];
    
    mutableContact.givenName = givenName;
    mutableContact.familyName = familyName;
    CNPhoneNumber * phone =[CNPhoneNumber phoneNumberWithStringValue:phoneNumber];
    
    mutableContact.phoneNumbers = [[NSArray alloc] initWithObjects:[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:phone], nil];
    CNContactStore *store = [[CNContactStore alloc] init];
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest addContact:mutableContact toContainerWithIdentifier:store.defaultContainerIdentifier];
    
    NSError *error;
    if([store executeSaveRequest:saveRequest error:&error]) {
        NSLog(@"save");
        [self reloadContactList];
    }else {
        NSLog(@"save error");
    }
}



-(void)updateContact:(CNContact*)contact memo:(NSString*)memo{
    CNMutableContact *mutableContact = contact.mutableCopy;
    
    mutableContact.note = memo;
    
    CNContactStore *store = [[CNContactStore alloc] init];
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    [saveRequest updateContact:mutableContact];
    
    NSError *error;
    if([store executeSaveRequest:saveRequest error:&error]) {
        NSLog(@"save");
    }else {
        NSLog(@"save error : %@", [error description]);
    }
}


-(void)deleteContact:(CNContact*)contact {
    CNMutableContact *mutableContact = contact.mutableCopy;
    
    CNContactStore *store = [[CNContactStore alloc] init];
    CNSaveRequest *deleteRequest = [[CNSaveRequest alloc] init];
    [deleteRequest deleteContact:mutableContact];
    
    NSError *error;
    if([store executeSaveRequest:deleteRequest error:&error]) {
        NSLog(@"delete complete");
        [self reloadContactList];
    }else {
        NSLog(@"delete error : %@", [error description]);
    }
    
}
#pragma mark -
#pragma mark Load Contact Method

-(void)loadContactView:(CNContact*)contact {
    // Create a new contact view
    CNContactViewController *contactController = [CNContactViewController viewControllerForContact:contact];
    contactController.delegate = self;
    contactController.allowsEditing = YES;
    contactController.allowsActions = YES;
    
    // Display the view
    [self.navigationController pushViewController:contactController animated:YES];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"contactList count = %d", (int)[cities count]);
//    return [cities count];
    if(_isFiltered == YES)
    {
        return [_filteredCities count];
    }
    else
    {
        return [cities count];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[contTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    CNContact* contact = [cities objectAtIndex:indexPath.row];
//    cell1.textLabel.text = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
    if(_isFiltered == YES){
        cell1.textLabel.text = [_filteredCities objectAtIndex:indexPath.row];
    }
    else{
        
        cell1.textLabel.text = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
    }

    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    iv.image = [UIImage imageNamed:@"5@3x20170720"];
    cell1.imageView.image=iv.image;
    iv.layer.masksToBounds = YES;
    
    CGSize itemSize = CGSizeMake(30, 30);
    UIGraphicsBeginImageContextWithOptions(itemSize, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
    [cell1.imageView.image drawInRect:imageRect];
    cell1.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;

    return  cell1;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if(searchText.length == 0)
    {
        _isFiltered = NO;
    }else {
        _isFiltered = YES;
        _filteredCities = [[NSMutableArray alloc]init];

//        for(NSString *cityName in cities)
//        {
//
//            NSRange cityNameRange = [cityName rangeOfString:searchText options:NSCaseInsensitiveSearch];
//            
//            if(cityNameRange.location != NSNotFound)
//            {
//                [_filteredCities addObject:cityName];
//                
//            }
//        }


        
    }
    [_myTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [_searchBar resignFirstResponder];
}

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
   
        //Create repository objects contacts
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        
        NSArray *keys = [[NSArray alloc]initWithObjects:CNContactIdentifierKey, CNContactEmailAddressesKey, CNContactBirthdayKey, CNContactImageDataKey, CNContactPhoneNumbersKey, CNContactViewController.descriptorForRequiredKeys, nil];
        
        // Create a request object
        CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
        request.predicate = nil;
    AddDetailViewController *meVc = [[AddDetailViewController alloc]init];

        [contactStore enumerateContactsWithFetchRequest:request
                                                  error:nil
                                             usingBlock:^(CNContact* __nonnull contact, BOOL* __nonnull stop)
         {
             NSString *phoneNumber = @"";
             if( contact.phoneNumbers)
                 phoneNumber = [[[contact.phoneNumbers firstObject] value] stringValue];
             meVc.strname = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
             meVc.strPhone = [NSString stringWithFormat:@"%@", phoneNumber];
             
         }];
    [self.navigationController pushViewController:meVc animated:YES];

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


@end

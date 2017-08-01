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

@interface AddressBookViewController ()<CNContactViewControllerDelegate, CNContactPickerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *contactList;
@property(nonatomic,strong)UITableView *myTableView;

@end

@implementation AddressBookViewController
@synthesize contactList;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    contactList = [[NSMutableArray alloc] init];
    [self loadContactList];
    
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.view addSubview:self.myTableView];
    [self.myTableView registerNib:[UINib nibWithNibName:@"contTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

}
-(void)reloadContactList {
    [contactList removeAllObjects];
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
             
             
             [contactList addObject:contact];
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
    NSLog(@"contactList count = %d", (int)[contactList count]);
    return [contactList count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell1 == nil) {
        cell1 = [[contTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    CNContact* contact = [contactList objectAtIndex:indexPath.row];
    cell1.textLabel.text = [NSString stringWithFormat:@"%@%@", contact.familyName, contact.givenName];
    
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

#pragma mark -
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    


    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

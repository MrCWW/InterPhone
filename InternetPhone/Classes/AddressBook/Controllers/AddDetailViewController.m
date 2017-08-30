//
//  AddDetailViewController.m
//  InternetPhone
//
//  Created by wangkun on 2017/8/1.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "AddDetailViewController.h"
#import "PhoneViewController.h"
#import "AddRessBookViewController.h"
#import <Contacts/Contacts.h>

@interface AddDetailViewController ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIButton *btnone;
@property (strong,nonatomic) UIButton *btnTwo;
@property (nonatomic,copy) UITextField *mmField;
@property (nonatomic,copy) UITextField *mxmField;
@property (nonatomic,copy) UITextField *sipField;
@property (nonatomic,copy) UITextField *phoneField;


@end

@implementation AddDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];


}
- (void)createUI{
    self.scrollView = [[UIScrollView alloc]initWithFrame:HCGRECT(0, 0, ScreenWidth, ScreenHeight - 135)];
//    NSInteger scrollHeight = self.scrollView.height;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
//    self.scrollView.contentSize = CGSizeMake(ScreenWidth, scrollHeight );
    [self.view addSubview:self.scrollView];
    
    UIView *view = [[UIView alloc] initWithFrame:HCGRECT(0, 0, ScreenWidth, ScreenHeight-100)];
    [self.scrollView addSubview:view];

    UIView *vvv = [[UIView alloc] initWithFrame:HCGRECT(0, 0, ScreenWidth, 50)];
    vvv.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1];
    [view addSubview:vvv];
    
    _btnTwo = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnTwo.frame = CGRectMake(0, 3, 150, 45);
    [_btnTwo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnTwo setImageEdgeInsets:UIEdgeInsetsMake(0, -85, 0, 0)];
    [_btnTwo setImage:[UIImage imageNamed:@"btn_backBlack"] forState:UIControlStateNormal];
    [_btnTwo addTarget:self action:@selector(clickbacktwo:) forControlEvents:UIControlEventTouchUpInside];
    [vvv addSubview:_btnTwo];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(ScreenWidth/2+40, 3, 80, 45);
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [button2 setImage:[UIImage imageNamed:@"delete_default"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clickbacksc:) forControlEvents:UIControlEventTouchUpInside];
    [vvv addSubview:button2];
    
    _btnone = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnone.frame = CGRectMake(ScreenWidth-80, 3, 80, 45);
    [_btnone setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btnone setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [_btnone setImage:[UIImage imageNamed:@"edit_default"] forState:UIControlStateNormal];
    [_btnone addTarget:self action:@selector(clickbackxg:) forControlEvents:UIControlEventTouchUpInside];
    
    _btnone.selected = NO;
    [vvv addSubview:_btnone];
    
    UIImageView *im  =[[UIImageView alloc] initWithFrame:CGRectMake(ScreenWidth/2-40, 80, 100, 100)];
    UIImage *image = [UIImage imageNamed:@"5@3x20170720"];
    im.image = image;
    im.layer.masksToBounds = YES;
    im.layer.cornerRadius = im.frame.size.width/2;
    [view addSubview:im];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-80,CGRectGetMaxY(im.frame)+5, 180, 30)];
    lb.text = _strname;
    lb.textAlignment = NSTextAlignmentCenter;
    lb.textColor = [UIColor blackColor];
    lb.font = [UIFont systemFontOfSize:16];
    [view addSubview:lb];
    
    UILabel *lb1 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-80,CGRectGetMaxY(lb.frame)+5, 180, 30)];
    lb1.text = @"電話號碼";
    lb1.textAlignment = NSTextAlignmentCenter;
    lb1.textColor = [UIColor colorWithRed:98.0/255 green:98.0/255  blue:98.0/255 alpha:1.0f];
    lb1.font = [UIFont systemFontOfSize:13];
    [view addSubview:lb1];
    
    UILabel *lb2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-80,CGRectGetMaxY(lb1.frame)+5, 180, 30)];
    lb2.text = _strPhone;
    lb2.textAlignment = NSTextAlignmentCenter;
    lb2.textColor = [UIColor colorWithRed:98.0/255 green:98.0/255  blue:98.0/255 alpha:1.0f];
    lb2.font = [UIFont systemFontOfSize:13];
    [view addSubview:lb2];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(ScreenWidth/2-10, CGRectGetMaxY(lb2.frame)+5, 40, 40);
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button1 setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 10, 10)];
    button1.backgroundColor = [UIColor orangeColor];
    [button1 setImage:[UIImage imageNamed:@"20170720-中華電信-撥號"] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(clickbackphone:) forControlEvents:UIControlEventTouchUpInside];
    button1.layer.masksToBounds = YES;
    button1.layer.cornerRadius = button1.frame.size.width/2;
    [view addSubview:button1];


}

//
- (void)clickbacktwo:(UIBarButtonItem *)but {
    if ((self.btnone.selected = !self.btnone.selected)) {
        AddRessBookViewController *aVC = [[AddRessBookViewController alloc] init];
        [self addChildViewController:aVC];
        [self.scrollView addSubview:aVC.view];

    }else{
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        [_btnone setImage:[UIImage imageNamed:@"edit_default"] forState:UIControlStateNormal];
        [_btnTwo setImage:[UIImage imageNamed:@"btn_backBlack"] forState:UIControlStateNormal];
        [self createUI];

    }
   
}
//删除
- (void)clickbacksc:(UIBarButtonItem *)but {
    UIAlertView *alerat = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认删除联系人？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alerat.tag = 1001;
    alerat.delegate = self;
    [alerat show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 1001) {
        if (buttonIndex == 0) {
            
            
        }else if(buttonIndex == 1){
            //删除联系人
            AddRessBookViewController *aVC = [[AddRessBookViewController alloc] init];
            [self addChildViewController:aVC];
            aVC.name = _strname;
            [self.scrollView addSubview:aVC.view];



        }
    }
}


//修改
- (void)clickbackxg:(UIBarButtonItem *)but {
    if ((self.btnone.selected = !self.btnone.selected)) {
        
        [_btnone setImage:[UIImage imageNamed:@"valid_default"] forState:UIControlStateNormal];
        [_btnTwo setImage:[UIImage imageNamed:@"cancel_edit_default"] forState:UIControlStateNormal];
        self.btnone.userInteractionEnabled = YES;
        
            UIView *viewphone  = [[UIView alloc] initWithFrame:CGRectMake(0, 180, ScreenWidth, ScreenHeight)];
            viewphone.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:viewphone];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-3,5, 100, 30)];
            label.text = @"姓名";
            [viewphone addSubview:label];
            _mmField= [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label.frame)+5, ScreenWidth-46, 30)];
            _mmField.backgroundColor = [UIColor colorWithRed:222.0/255 green:222.0/255  blue:222.0/255 alpha:1.0f];
            [_mmField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
            _mmField.text = _strname;
            [viewphone addSubview:_mmField];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-20,CGRectGetMaxY(_mmField.frame)+5, 100, 30)];
            label2.text = @"sip 地址";
            [viewphone addSubview:label2];
            _sipField= [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label2.frame)+5, ScreenWidth-46, 30)];
            _sipField.backgroundColor = [UIColor colorWithRed:222.0/255 green:222.0/255  blue:222.0/255 alpha:1.0f];
            [_sipField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
            [viewphone addSubview:_sipField];
            
            UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(ScreenWidth/2-20,CGRectGetMaxY(_sipField.frame)+5, 100, 30)];
            label3.text = @"電話號碼";
            [viewphone addSubview:label3];
            _phoneField= [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label3.frame)+5, ScreenWidth-46, 30)];
            _phoneField.backgroundColor = [UIColor colorWithRed:222.0/255 green:222.0/255  blue:222.0/255 alpha:1.0f];
            [_phoneField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
            _phoneField.text = _strPhone;
            [viewphone addSubview:_phoneField];
        

        
    }else {

//        [self saveContact:_mmField.text givenName:@"" phoneNumber:_phoneField.text];

        //删除子View
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_btnone setImage:[UIImage imageNamed:@"edit_default"] forState:UIControlStateNormal];
        [_btnTwo setImage:[UIImage imageNamed:@"btn_backBlack"] forState:UIControlStateNormal];
        self.btnTwo.userInteractionEnabled = YES;
        [self createUI];

    }
    
}
-(void)saveContact:(NSString*)familyName givenName:(NSString*)givenName phoneNumber:(NSString*)phoneNumber {
    CNMutableContact *mutableContact = [[CNMutableContact alloc] init];
    
    mutableContact.givenName = givenName;
    mutableContact.familyName = familyName;
    CNPhoneNumber * phone =[CNPhoneNumber phoneNumberWithStringValue:phoneNumber];
    
    mutableContact.phoneNumbers = [[NSArray alloc] initWithObjects:[CNLabeledValue labeledValueWithLabel:CNLabelPhoneNumberiPhone value:phone], nil];
    CNContactStore *store = [[CNContactStore alloc] init];
    CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
    
    [saveRequest addContact:mutableContact toContainerWithIdentifier:store.defaultContainerIdentifier];
    
}


- (void)clickbackphone:(UIBarButtonItem *)but {
    PhoneViewController *meVc = [[PhoneViewController alloc]init];
    meVc.strPhone = _strPhone;
    [self.navigationController pushViewController:meVc animated:YES];
    
    NSInteger scrollHeight = self.scrollView.height;
    PhoneViewController *aVC = [[PhoneViewController alloc] init];
    aVC.strPhone = _strPhone;
    [self addChildViewController:aVC];
    aVC.view.frame = HCGRECT(0, 0, ScreenWidth, scrollHeight);
    aVC.view.backgroundColor  = [UIColor whiteColor];
    [self.scrollView addSubview:aVC.view];
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

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

@interface AddDetailViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIButton *btnone;
@property (strong,nonatomic) UIButton *btnTwo;
@property (nonatomic,copy) UITextField *mmField;
@property (nonatomic,copy) UITextField *mxmField;
@property (nonatomic,copy) UITextField *sipField;
@property (nonatomic,copy) UITextField *phoneField;
@property (strong,nonatomic) UILabel *labelone;


@end

@implementation AddDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self createUI];
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    //当 Keyboard 弹出时会系统会发送 UIKeyboardWillChangeFrameNotification 通知
//    [center addObserver:self selector:@selector(changeTextfieldFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = YES;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];


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
//        AddRessBookViewController *aVC = [[AddRessBookViewController alloc] init];
//        [self addChildViewController:aVC];
//        [self.scrollView addSubview:aVC.view];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];

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
            
            CNContactStore *store = [CNContactStore new];

            //检索条件，检索所有联系人
            NSPredicate * predicate = [CNContact predicateForContactsMatchingName:_strname];
            NSLog(@"%@",predicate);

            //提取数据
            NSArray * contacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactGivenNameKey] error:nil];
            NSLog(@"%@",contacts);
            
            CNContact *cont = [contacts lastObject];
            CNMutableContact *contact = [cont mutableCopy];

            CNSaveRequest *deleteRequest = [[CNSaveRequest alloc] init];
            [deleteRequest deleteContact:contact];
            if(![store executeSaveRequest:deleteRequest error:nil])
            {
                NSLog(@"can't be updated");
            }
            AddRessBookViewController *aVC = [[AddRessBookViewController alloc] init];
            [self addChildViewController:aVC];
            [self.scrollView addSubview:aVC.view];
            
                
        }
    }
}



//修改
- (void)clickbackxg:(UIBarButtonItem *)but {
    if ((self.btnone.selected = !self.btnone.selected)) {
        _mmField.text = nil;
        _sipField.text = nil;
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
            label2.text = @"電話號碼";
            [viewphone addSubview:label2];
            _sipField= [[UITextField alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(label2.frame)+5, ScreenWidth-46, 30)];
            _sipField.backgroundColor = [UIColor colorWithRed:222.0/255 green:222.0/255  blue:222.0/255 alpha:1.0f];
            [_sipField setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        _sipField.text = _strPhone;
//        NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
//        dict1[NSForegroundColorAttributeName] = [UIColor blackColor];
//        NSAttributedString *attribute1 = [[NSAttributedString alloc] initWithString:_sipField.placeholder attributes:dict1];
//        [_sipField setAttributedPlaceholder:attribute1];
        [viewphone addSubview:_sipField];
       
        
        
    }else {

        //删除子View
        [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_btnone setImage:[UIImage imageNamed:@"edit_default"] forState:UIControlStateNormal];
        [_btnTwo setImage:[UIImage imageNamed:@"btn_backBlack"] forState:UIControlStateNormal];
        self.btnTwo.userInteractionEnabled = YES;
        [self createUI];

        [self clickbacktz];
    }
    
}
- (void)clickbacktz{


    if (_mmField.text == nil|| [_mmField.text length] == 0||_sipField.text == nil|| [_sipField.text length] == 0) {
        
    }else {

        CNContactStore *store = [CNContactStore new];
        //检索条件，检索所有名字中有zhang的联系人
        NSPredicate * predicate = [CNContact predicateForContactsMatchingName:_strname];
        //提取数据
        NSArray * contacts = [store unifiedContactsMatchingPredicate:predicate keysToFetch:@[CNContactGivenNameKey] error:nil];
        NSLog(@"%@",contacts);

        CNContact *cont = [contacts lastObject];
        CNMutableContact *contact2 = [cont mutableCopy];

        //修改联系人的属性
        contact2.givenName = _mmField.text;
        //实例化一个CNSaveRequest
        CNSaveRequest * saveRequest = [[CNSaveRequest alloc]init];
        [saveRequest updateContact:contact2];
        NSLog(@"%@",saveRequest);
        if(![store executeSaveRequest:saveRequest error:nil])
        {
            NSLog(@"can't be updated");
        }
        //
        AddRessBookViewController *aVC = [[AddRessBookViewController alloc] init];
        [self addChildViewController:aVC];
        [self.scrollView addSubview:aVC.view];
    }
    
}


//移除通知 收回键盘
-(void)keyboardHide:(UITapGestureRecognizer *)gestureRecognizer

{
    
    [self.view endEditing:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}
- (void)clickbackphone:(UIBarButtonItem *)but {
    
    [self clickbacktwo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callActionNoti" object:@{@"phone":_strPhone,@"name":_strname}];
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

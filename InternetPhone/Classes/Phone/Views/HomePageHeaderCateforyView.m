//
//  HomePageHeaderCateforyView.m
//  ZuLinLa
//
//  Created by DUC-apple3 on 2017/6/28.
//  Copyright © 2017年 DUC-apple3. All rights reserved.
//

#import "HomePageHeaderCateforyView.h"
#import "HomePageHeaderCollectionViewCell.h"
//#import "HomePageCategoryModel.h"

#define BGViewHeight 218
#define ItemWidth (ScreenWidth-60)/3

#define CellSec @"CellSec"
@interface HomePageHeaderCateforyView()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) NSArray *imageDataArr;
@end
@implementation HomePageHeaderCateforyView

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
//- (NSMutableArray *)imageDataArr {
//    if (!_imageDataArr) {
//        _imageDataArr = [NSMutableArray array];
//    }
//    return _imageDataArr;
//}
- (void)setCategoryArray:(NSArray *)categoryArray {
    _categoryArray = categoryArray;
//    for (HomePageCategoryModel *model in _categoryArray) {
//        [self.dataArr addObject:model.name];
//       
//    }
    [self.collectionView reloadData];
    
}
//- (NSArray *)categoryArray {
//  
//        for (HomePageCategoryModel *model in _categoryArray) {
//            [self.dataArr addObject:model.name];
//        }
//        [self.collectionView reloadData];
//    
//    
//    return _categoryArray;
//}

- (instancetype)initWithFrame:(CGRect)frame imageArr:(NSArray *)imageArr titleArr:(NSArray *)titleArr{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        UIImageView *imageBG = [[UIImageView alloc] initWithFrame:HCGRECT(20, 20, self.width - 40, self.height - 40)];
        imageBG.image = [UIImage imageNamed:@"20170720-中華電信-撥號背景圖"];
        [self addSubview:imageBG];
        if (imageArr) {
            self.imageDataArr = [NSArray arrayWithArray:imageArr];
        }
        if (titleArr) {
            self.dataArr = [NSMutableArray arrayWithArray:titleArr];
        }
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //分区之间的间距
        flowLayout.sectionInset = UIEdgeInsetsMake(20,20,20,20);
        //cell之间的最小间距
        flowLayout.minimumLineSpacing = 10;//行间距
        flowLayout.minimumInteritemSpacing = 5;//列间距
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height) collectionViewLayout:flowLayout];
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        self.collectionView.backgroundColor = [UIColor clearColor];
        [self.collectionView registerNib:[UINib nibWithNibName:@"HomePageHeaderCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellSec];
        [self addSubview:self.collectionView];
        
      
        
        
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageDataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    HomePageCategoryModel *model = self.categoryArray[indexPath.row];
    HomePageHeaderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellSec forIndexPath:indexPath];
//    cell.titleLabel.text = self.dataArr[indexPath.row];
    if (self.imageDataArr) {
        
        cell.imageViews.image = [UIImage imageNamed:self.imageDataArr[indexPath.row]];
    }else {
    
//        [cell.imageViews sd_setImageWithURL:[NSURL URLWithString:model.image]];
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    HomePageCategoryModel *model = self.categoryArray[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(selectdeCategoryAction:)]) {
        [self.delegate selectdeCategoryAction:indexPath.row];
    }
    
}
- (CGSize) collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat heightItem = (self.height-70)/4;
    return CGSizeMake(ItemWidth,heightItem);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

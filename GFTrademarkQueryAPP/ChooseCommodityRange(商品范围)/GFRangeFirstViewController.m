//
//  GFRangeFirstViewController.m
//  GFTrademark
//
//  Created by 夏伟耀 on 16/3/17.
//  Copyright © 2016年 gf. All rights reserved.
//

#import "GFRangeFirstViewController.h"
#import "GFButton.h"

@interface GFRangeFirstViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    BOOL chooseData[45];
}

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property(nonatomic,assign) NSInteger mark;

@end

@implementation GFRangeFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 *  初始化界面
 */
- (void)initView {
    // 集合视图
    _layout = [[UICollectionViewFlowLayout alloc] init];
//    _layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.delaysContentTouches = NO;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"RangFirstCell"];
    [self.view addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-44);
        make.left.mas_equalTo(self.view.mas_left).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(0);
    }];

    //     配置确认按钮样式
    //[self setButton:_collectionView];
    
    _mark = 0;
    
}

-(void)setButton:(UICollectionView*)collectionView {
    
//     配置样式
    GFButton *confirmButton = [[GFButton alloc] init];
    [confirmButton addTarget:self action:@selector(chooseConfirm) forControlEvents:UIControlEventTouchUpInside];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setBackgroundImage:[UIImage imageNamed:@"bg_btn_login_pressed"] forState:UIControlStateNormal];
    [self.view addSubview:confirmButton];
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).with.offset(0);
        make.left.mas_equalTo(self.view).with.offset(0);
        make.right.mas_equalTo(self.view).with.offset(0);
        make.height.mas_equalTo(43);
    }];
    
}

// CollectionView代理方法，返回对应Section中item个数---------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 46;
}

// CollectionView代理方法，返回Section个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// CollectionView代理方法，返回每个Item的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 45) {
//        return CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width / 20 - 2);
//    } else {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width / 7 - 4, ([UIScreen mainScreen].bounds.size.height-88.0-140) / 7 );
//    }
}


//定义每个UICollectionViewCell横向的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(5, 2, 0, 2);
}

//定义每个UICollectionView最想横向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


// CollectionView代理方法，返回Item的样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    // cell重用
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RangFirstCell" forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    // 根据位置配置Cell
//    if (indexPath.row < 45) {
        return [self configureRangCell:cell inIndex:indexPath];
//    } else {
////        return [self configureConfirmCell:cell];
//    }
    return cell;
}

/**
 *  配置类别Cell
 *  @param cell      需要配置的Cell
 *  @param indexPath Cell的位置
 *  @return 配置完成的Cell
 */
- (UICollectionViewCell *)configureRangCell:(UICollectionViewCell *)cell inIndex:(NSIndexPath *)indexPath {
    // 配置显示标题
    NSInteger index = indexPath.row + 1;
    NSString *title = [NSString stringWithFormat:@"%ld", (long)index];
    if (indexPath.row + 1 < 10) {
        title = [NSString stringWithFormat:@"0%@", title];
    }
    
    // 配置按钮样式
    UIButton *button = [[UIButton alloc] init];
    [button addTarget:self action:@selector(chooseRang:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTag:indexPath.row];
    [button.layer setMasksToBounds:YES];
    [button.layer setCornerRadius:5];
    if (chooseData[indexPath.row]) {
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor colorWithRed:41.0/255 green:134.0/255 blue:227.0/255 alpha:1]];
    } else {
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor whiteColor]];
        [button.layer setBorderWidth:1];
        [button.layer setBorderColor:[UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1].CGColor];
    }
    
    if (indexPath.row == 45) {
        
        if (_mark == 0) {
            
            [button setTitle:@"全选" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.5];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor colorWithRed:41.0/255 green:134.0/255 blue:227.0/255 alpha:1]];
            
        } else {
            
            [button setTitle:@"重置" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:14.5];
            [button setBackgroundColor:[UIColor whiteColor]];
            [button.layer setBorderWidth:1];
            [button.layer setBorderColor:[UIColor colorWithRed:219.0/255 green:219.0/255 blue:219.0/255 alpha:1].CGColor];
        }
    }
    
    // 添加至Cell中
    [cell.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 0, 10);
//        make.edges.equalTo(cell.contentView).with.insets(padding);
        
        make.bottom.mas_equalTo(cell.contentView.mas_bottom).with.offset(0);
        make.left.equalTo(cell.contentView.mas_left).with.offset(2);
        make.right.equalTo(cell.contentView.mas_right).with.offset(-2);
        make.top.equalTo(cell.contentView.mas_top).with.offset(0);
        
    }];
//    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

/**
 *  配置确认按钮Cell
 *  @param cell 需要配置的Cell
 *  @return 配置完成的Cell
 */
//- (UICollectionViewCell *)configureConfirmCell:(UICollectionViewCell *)cell {
//
//    return cell;
//}

/**
 *  点击类别按钮事件
 *  @param button 点击的类别按钮
 */
- (void)chooseRang:(UIButton *)button {
    if (button.tag == 45) {
        
        if (_mark == 0) {
            
            for (int i = 0; i < 45; i++) {
                
                chooseData[i] = YES;
            }
            
            _mark = 1;
        } else {
            
            for (int i = 0; i < 45; i++) {
                
                chooseData[i] = NO;
            }
            
            _mark = 0;
        }
        
    } else {
    
        chooseData[button.tag] = !chooseData[button.tag];
        //    [self chooseConfirm];
    }
    
    [_collectionView reloadData];
    NSLog(@"%ld",(long)button.tag);

}

/**
 *  点击确认按钮事件
 */
- (void)chooseConfirm {
    
    NSMutableArray *data = [[NSMutableArray alloc] init];
    NSInteger markNumbr = 1;
    for (int i = 0; i < 45; i++) {
        
        if (chooseData[i]) {
            
            [data addObject:[NSString stringWithFormat:@"%02d", i + 1]];
        }
        
        if (chooseData[i] == NO) {
            
            markNumbr = 0;
        }
    }
//    self.firstArray = data;
    if (_dataResultDelegate) {
        
        
        if (markNumbr == 1) {
           
            //全选
            [_dataResultDelegate chooseRangeAllData];
        } else{
            
            //单选
            [_dataResultDelegate chooseRangeResultType:RangeTypeFirst Data:data];
        }
        
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end

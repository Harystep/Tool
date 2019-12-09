//
//  HRSecuritySimpleView.m
//  HRCommonTool
//
//  Created by pxsl on 2019/12/6.
//  Copyright © 2019 CCAPP. All rights reserved.
//

#import "HRSecuritySimpleView.h"
#import "HRFunctionSimpleViewCell.h"

@interface HRSecuritySimpleView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UILabel *titleL;

@property (strong, nonatomic) NSArray *dataArr;

@end

@implementation HRSecuritySimpleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createSubView];
    }
    return self;
}

- (void)createSubView {
    UILabel *titleL = [self createLabelOnTargetView:self withFrame:CGRectMake(0, 15, self.width, 20)];
    [titleL setLabelTextColor:kColorHex(@"#333333") text:@"456" withFont:17];
    [titleL setFontBold:17];
    titleL.textAlignment = NSTextAlignmentCenter;
    self.titleL = titleL;
    [self addSubview:self.collectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HRFunctionSimpleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HRFunctionSimpleViewCell" forIndexPath:indexPath];
    cell.dataDic = self.dataArr[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleL.frame) + 5, self.width, self.height - 50) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HRFunctionSimpleViewCell class] forCellWithReuseIdentifier:@"HRFunctionSimpleViewCell"];
        //追加视图的类型是UICollectionElementKindSectionHeader，也可以设置为UICollectionElementKindSectionFooter
        [self addSubview:_collectionView];
        //配置UICollectionViewFlowLayout属性
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        //每个itemsize的大小
        layout.itemSize = CGSizeMake(self.width / 4.0, 80);
        //每个section距离上方和下方20，左方和右方10
        //    垂直滚动(水平滚动设置UICollectionViewScrollDirectionHorizontal)
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _collectionView;
}

- (NSArray *)dataArr {
    if (_dataArr== nil) {
        _dataArr = @[@{@"image":@"",@"title":@"应急初报"},
                     @{@"image":@"",@"title":@"预警反馈"},
                     @{@"image":@"",@"title":@"应急反馈"},
                     @{@"image":@"",@"title":@"应急发布"}
                     ];
    }
    return _dataArr;
}

@end

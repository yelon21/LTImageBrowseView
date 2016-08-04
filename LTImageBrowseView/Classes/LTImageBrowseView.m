//
//  LTImageBrowseView.m
//  Pods
//
//  Created by yelon on 16/8/4.
//
//

#import "LTImageBrowseView.h"

@interface LTImageBrowseView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UIPageControl *pageControl;
@end

@implementation LTImageBrowseView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{

    [self setup];
}

-(void)layoutSubviews{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self lt_reloadData];
    });
}

- (void)setup {

    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    fl.minimumLineSpacing = 0.0;
    fl.minimumInteritemSpacing = 0.0;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:self.bounds
                                            collectionViewLayout:fl];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerClass:[LTBrowseImageCell class]
            forCellWithReuseIdentifier:@"LTBrowseImageCell"];
    
    UIView *superV = self;
    [superV addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeTop
                                                      multiplier:1.0
                                                        constant:0.0]];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0
                                                        constant:0.0]];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0
                                                        constant:0.0]];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.collectionView
                                                       attribute:NSLayoutAttributeRight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeRight
                                                      multiplier:1.0
                                                        constant:0.0]];
    
    self.pageControl = [[UIPageControl alloc]init];
    self.pageControl.hidesForSinglePage = YES;
    
    [superV addSubview:self.pageControl];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
                                                       attribute:NSLayoutAttributeHeight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:nil
                                                       attribute:NSLayoutAttributeNotAnAttribute
                                                      multiplier:1.0
                                                        constant:30.0]];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0
                                                        constant:0.0]];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0
                                                        constant:0.0]];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.pageControl
                                                       attribute:NSLayoutAttributeRight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeRight
                                                      multiplier:1.0
                                                        constant:0.0]];
}

- (void)lt_reloadData{

    [self.collectionView reloadData];
    
    NSUInteger index = self.defaultIndex;
    
    if (index >= self.pageControl.numberOfPages) {
        
        index = self.pageControl.numberOfPages - 1;
    }
    self.pageControl.currentPage = index;
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index
                                                                    inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionNone
                                        animated:NO];
}

-(NSUInteger)numberOfItems{

    return self.pageControl.numberOfPages;
}

-(NSUInteger)currentIndex{

    return self.pageControl.currentPage;
}
#pragma mark UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    CGPoint point = scrollView.contentOffset;
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    
    if ([self.ltDelegate respondsToSelector:@selector(lt_ImageBrowseView:didScrollToIndex:)]) {
        
        [self.ltDelegate lt_ImageBrowseView:self didScrollToIndex:indexPath.row];
    }
    self.pageControl.currentPage = indexPath.row;
}
#pragma mark UICollectionViewDataSource
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSInteger num = 0;
    
    if ([self.ltDelegate respondsToSelector:@selector(lt_ImageBrowseViewNumberOfItems)]) {
        
        num = [self.ltDelegate lt_ImageBrowseViewNumberOfItems];
    }
    
    self.pageControl.numberOfPages = num;
    
    return num;
}


//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LTBrowseImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LTBrowseImageCell" forIndexPath:indexPath];
    
    if ([self.ltDelegate respondsToSelector:@selector(lt_ImageBrowseView:ltCell:atIndex:)]) {
        
        [self.ltDelegate lt_ImageBrowseView:self
                                     ltCell:cell
                                    atIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return collectionView.bounds.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}
#pragma mark --UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}

@end

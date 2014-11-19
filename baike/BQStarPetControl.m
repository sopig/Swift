//
//  BQStarPetControl.m
//  boqiimall
//
//  Created by 张正超 on 14/11/18.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQStarPetControl.h"

#import "BQStarPetView.h"

#define color(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define color_grayGreenBack  color(247,246,236)
#define color_view  color(157,195,41)
#define color_text  color(91,91,91)


#define STAR_PET_VIEW_TAG 8888


#define BUTTON_WIDTH 80

static NSString *starPetTitle = @"我的宠物";
static NSString *notLoginTips =@"登录以后，即可查看我的宠物";

@interface BQStarPetControl ()
{
    UIImageView* _DetailImageView;
    UIView* _selectView;
    UIView* _lineView;
    id _target;
    SEL _act;

}

@property(nonatomic,readwrite,strong)UILabel *starPetLabel;
@property(nonatomic,readwrite,strong)UILabel* petListView;
@property(nonatomic,readwrite,strong)NSMutableArray *constraints;


@end


@implementation BQStarPetControl


/**
 *  判断用户是否登录
 *
 *  @return 是否登录
 */
- (BOOL)isUserLogin{
    return [UserUnit isUserLogin];
}


/**
 *  初始化
 *
 *  @param frame frame description
 *
 *  @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = color_grayGreenBack;
        
        _selectView = [[UIView alloc]initWithFrame:CGRectZero];
        _selectView.backgroundColor = color_view;
        _selectView.translatesAutoresizingMaskIntoConstraints=NO;
        
        _starPetLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _starPetLabel.textAlignment = NSTextAlignmentLeft;
        _starPetLabel.textColor = color_text;
        _starPetLabel.font = defFont15;
        _starPetLabel.text = starPetTitle;
        
        _starPetLabel.translatesAutoresizingMaskIntoConstraints=NO;
        
        _DetailImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _DetailImageView.image = [UIImage imageNamed:@"arrow_detail_big"];
        _DetailImageView.translatesAutoresizingMaskIntoConstraints=NO;
        
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.backgroundColor = color_dedede;
        _lineView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _petListView = [[UILabel alloc]initWithFrame:CGRectZero];
        _petListView.backgroundColor = color_grayGreenBack;
        _petListView.translatesAutoresizingMaskIntoConstraints = NO;
       
        [self addSubview:_selectView];
        [self addSubview:_starPetLabel];
        [self addSubview:_lineView];
        [self addSubview:_petListView];
        [self addSubview:_DetailImageView];
        
        //常量数据初始化
        _constraints = [NSMutableArray array];
        _petsDataSource = [NSMutableArray array];
        [_petsDataSource addObjectsFromArray:@[@10,@20,@30]];
       
        [self layoutSubviews];
    }
    return self;
}


- (void)layoutSubviews{
    
    [self mainUI];
    [self petListUI];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}


/**
 *  主界面UI约束更新
 */
- (void)mainUI{
    
    NSDictionary *viewDict = NSDictionaryOfVariableBindings(_starPetLabel,_petListView,_DetailImageView,_selectView,_lineView);
    NSDictionary *metricDict = @{@"padding":@5,@"gap":@10};
   
    NSString *vhl1 = @"H:|[_selectView(padding)]-gap-[_starPetLabel(>=100)][_DetailImageView(9)]-|";
    NSString *vhl2 = @"V:|[_selectView(40)][_lineView(1)][_petListView(>=40)]|";
    NSString *vhl3 = @"V:|[_starPetLabel(40)][_lineView(1)][_petListView(>=40)]|";
    NSString *vhl4 = @"V:|[_starPetLabel(40)][_lineView(1)][_petListView(>=40)]|";
    NSString *vhl5 = @"V:|-13-[_DetailImageView(15)]-5-[_lineView(1)][_petListView(>=40)]|";
    
    NSString *vhl6 = @"H:|[_petListView]|";
    NSString *vhl7 = @"H:|[_lineView]|";
    
    NSArray *vfls =@[vhl1,vhl2,vhl3,vhl4,vhl5,vhl6,vhl7];
    [self addConstraints:[self addConstraintsWithVFL:vfls metric:metricDict views:viewDict]];
}


/**
 *  判断处于什么枚举状态
 *
 *  @return return value description
 */
- (controlState)judgeCurrentStatu{
    return [self isUserLogin]?controlStateNormal:controlStateNotLogin;
}



/**
 *  根据状态生成约束
 */
- (void)petListUI{
    switch ([self judgeCurrentStatu]) {
        case controlStateNotLogin:
        {
            if (_petsDataSource.count >3) {
                return;
            }
            
            if (_petsDataSource.count == 0) {
                BQStarPetView *starPetView = [[BQStarPetView alloc]initWithFrame:CGRectZero];
                starPetView.nameLabel.text =@"添加宠物";
//                            starPetView.layer.borderColor = [UIColor blackColor].CGColor;
//                            starPetView.layer.borderWidth =1;
                starPetView.translatesAutoresizingMaskIntoConstraints=NO;
                starPetView.image = [UIImage imageNamed:@"Default-568h"];
                starPetView.delegate = self;
                starPetView.selector = @selector(controlClick:);
                starPetView.paramsObject = @(0);
                [self addSubview:starPetView];
                NSDictionary *viewDict = NSDictionaryOfVariableBindings(_lineView,starPetView);
                NSDictionary *metricDict = @{@"padding":@5,@"gap":@10};
                
                NSString*vhl1 = [NSString stringWithFormat:@"H:[starPetView(80)]"];
                NSString*vhl2 =@"V:[_lineView(1)][starPetView(80)]";
                NSArray *vfls =@[vhl1,vhl2];
                [self addConstraints:[self addConstraintsWithVFL:vfls metric:metricDict views:viewDict]];
                
                
                [self addConstraint:[NSLayoutConstraint constraintWithItem:starPetView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_petListView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
                [self addConstraint:[NSLayoutConstraint constraintWithItem:starPetView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_petListView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
            }
            else if(_petsDataSource.count == 1){
                /**
                 宠物按钮
                 */
                BQStarPetView *starPetView = [[BQStarPetView alloc]initWithFrame:CGRectZero];
                starPetView.nameLabel.text = @"添加宠物";
//                starPetView.layer.borderColor = [UIColor blackColor].CGColor;
//                starPetView.layer.borderWidth = 1;
                starPetView.paramsObject = @(0);
                starPetView.translatesAutoresizingMaskIntoConstraints=NO;
                
                starPetView.image = [UIImage imageNamed:@"Default-568h"];
                starPetView.delegate = self;
                starPetView.selector = @selector(controlClick:);
                [self addSubview:starPetView];
                
                
                /**
                 添加按钮
                 */
                BQStarPetView *add = [[BQStarPetView alloc]initWithFrame:CGRectZero];
                add.nameLabel.text = @"添加宠物";
//                add.layer.borderColor = [UIColor blackColor].CGColor;
//                add.layer.borderWidth = 1;
                
                add.paramsObject = @(1);
                add.translatesAutoresizingMaskIntoConstraints=NO;
                
                add.image = [UIImage imageNamed:@"Default-568h"];
                add.delegate = self;
                add.selector = @selector(controlClick:);
                [self addSubview:add];
                
                
                NSDictionary *viewDict = NSDictionaryOfVariableBindings(_lineView,starPetView,add);
                NSDictionary *metricDict = @{@"padding":@5,@"gap":@10};
                
                NSString*vhl1 = [NSString stringWithFormat:@"H:[starPetView(80)]"];
                NSString*vhl2 =@"V:[_lineView(1)][starPetView(80)]";
                
                NSString*vhl3 = [NSString stringWithFormat:@"H:[add(80)]"];
                NSString*vhl4 =@"V:[_lineView(1)][add(80)]";
                NSArray *vfls =@[vhl1,vhl2,vhl3,vhl4];
                [self addConstraints:[self addConstraintsWithVFL:vfls metric:metricDict views:viewDict]];
                
                [self setEdge:self view:starPetView attr:NSLayoutAttributeLeft constant:40];
                [self setEdge:self view:starPetView attr:NSLayoutAttributeTop constant:60];
             
                [self setEdge:self view:add attr:NSLayoutAttributeTop constant:60];
                [self setEdge:self view:add attr:NSLayoutAttributeLeft constant:40+80+80];
               
            }else if(_petsDataSource.count == 2){
                /**
                 宠物按钮
                 */
                BQStarPetView *starPetView = [[BQStarPetView alloc]initWithFrame:CGRectZero];
                starPetView.nameLabel.text = @"添加宠物";
//                starPetView.layer.borderColor = [UIColor blackColor].CGColor;
//                starPetView.layer.borderWidth = 1;
                starPetView.paramsObject = @(0);
                starPetView.translatesAutoresizingMaskIntoConstraints=NO;
                
                starPetView.image = [UIImage imageNamed:@"Default-568h"];
                starPetView.delegate = self;
                starPetView.selector = @selector(controlClick:);
                [self addSubview:starPetView];
                
                
                BQStarPetView *starPetView2 = [[BQStarPetView alloc]initWithFrame:CGRectZero];
                starPetView2.nameLabel.text = @"添加宠物";
//                starPetView2.layer.borderColor = [UIColor blackColor].CGColor;
//                starPetView2.layer.borderWidth = 1;
                starPetView2.paramsObject = @(1);
                starPetView2.translatesAutoresizingMaskIntoConstraints=NO;
                
                starPetView2.image = [UIImage imageNamed:@"Default-568h"];
                starPetView2.delegate = self;
                starPetView2.selector = @selector(controlClick:);
                [self addSubview:starPetView2];
                
                /**
                 添加按钮
                 */
                BQStarPetView *add = [[BQStarPetView alloc]initWithFrame:CGRectZero];
                add.nameLabel.text = @"添加宠物";
//                add.layer.borderColor = [UIColor blackColor].CGColor;
//                add.layer.borderWidth = 1;
                
                add.paramsObject = @(2);
                add.translatesAutoresizingMaskIntoConstraints=NO;
                
                add.image = [UIImage imageNamed:@"Default-568h"];
                add.delegate = self;
                add.selector = @selector(controlClick:);
                [self addSubview:add];
                
                
                NSDictionary *viewDict = NSDictionaryOfVariableBindings(_lineView,starPetView,starPetView2,add);
                NSDictionary *metricDict = @{@"padding":@5,@"gap":@10};
                
                NSString*vhl1 = [NSString stringWithFormat:@"H:[starPetView(80)]"];
                NSString*vhl2 =@"V:[_lineView(1)][starPetView(80)]";
                
                NSString*vhl3 = [NSString stringWithFormat:@"H:[starPetView2(80)]"];
                NSString*vhl4 =@"V:[_lineView(1)][starPetView2(80)]";
                
                NSString*vhl5 = [NSString stringWithFormat:@"H:[add(80)]"];
                NSString*vhl6 =@"V:[_lineView(1)][add(80)]";
                NSArray *vfls =@[vhl1,vhl2,vhl3,vhl4,vhl5,vhl6];
                [self addConstraints:[self addConstraintsWithVFL:vfls metric:metricDict views:viewDict]];
                
                [self setEdge:self view:starPetView attr:NSLayoutAttributeLeft constant:20];
                [self setEdge:self view:starPetView attr:NSLayoutAttributeTop constant:60];
                
                [self setEdge:self view:starPetView2 attr:NSLayoutAttributeTop constant:60];
                [self setEdge:self view:starPetView2 attr:NSLayoutAttributeLeft constant:20+80+20];
                
                [self setEdge:self view:add attr:NSLayoutAttributeTop constant:60];
                [self setEdge:self view:add attr:NSLayoutAttributeLeft constant:20+80+20+80+20];
                
            }else if(_petsDataSource.count == 3){
                /**
                 宠物按钮
                 */
                BQStarPetView *starPetView = [[BQStarPetView alloc]initWithFrame:CGRectZero];
                starPetView.nameLabel.text = @"添加宠物";
                //                starPetView.layer.borderColor = [UIColor blackColor].CGColor;
                //                starPetView.layer.borderWidth = 1;
                starPetView.paramsObject = @(0);
                starPetView.translatesAutoresizingMaskIntoConstraints=NO;
                
                starPetView.image = [UIImage imageNamed:@"Default-568h"];
                starPetView.delegate = self;
                starPetView.selector = @selector(controlClick:);
                [self addSubview:starPetView];
                
                
                BQStarPetView *starPetView2 = [[BQStarPetView alloc]initWithFrame:CGRectZero];
                starPetView2.nameLabel.text = @"添加宠物";
                //                starPetView2.layer.borderColor = [UIColor blackColor].CGColor;
                //                starPetView2.layer.borderWidth = 1;
                starPetView2.paramsObject = @(1);
                starPetView2.translatesAutoresizingMaskIntoConstraints=NO;
                
                starPetView2.image = [UIImage imageNamed:@"Default-568h"];
                starPetView2.delegate = self;
                starPetView2.selector = @selector(controlClick:);
                [self addSubview:starPetView2];
                
                /**
                 添加按钮
                 */
                BQStarPetView *add = [[BQStarPetView alloc]initWithFrame:CGRectZero];
                add.nameLabel.text = @"添加宠物";
                //                add.layer.borderColor = [UIColor blackColor].CGColor;
                //                add.layer.borderWidth = 1;
                
                add.paramsObject = @(2);
                add.translatesAutoresizingMaskIntoConstraints=NO;
                
                add.image = [UIImage imageNamed:@"Default-568h"];
                add.delegate = self;
                add.selector = @selector(controlClick:);
                [self addSubview:add];
                
                
                NSDictionary *viewDict = NSDictionaryOfVariableBindings(_lineView,starPetView,starPetView2,add);
                NSDictionary *metricDict = @{@"padding":@5,@"gap":@10};
                
                NSString*vhl1 = [NSString stringWithFormat:@"H:[starPetView(80)]"];
                NSString*vhl2 =@"V:[_lineView(1)][starPetView(80)]";
                
                NSString*vhl3 = [NSString stringWithFormat:@"H:[starPetView2(80)]"];
                NSString*vhl4 =@"V:[_lineView(1)][starPetView2(80)]";
                
                NSString*vhl5 = [NSString stringWithFormat:@"H:[add(80)]"];
                NSString*vhl6 =@"V:[_lineView(1)][add(80)]";
                NSArray *vfls =@[vhl1,vhl2,vhl3,vhl4,vhl5,vhl6];
                [self addConstraints:[self addConstraintsWithVFL:vfls metric:metricDict views:viewDict]];
                
                [self setEdge:self view:starPetView attr:NSLayoutAttributeLeft constant:20];
                [self setEdge:self view:starPetView attr:NSLayoutAttributeTop constant:60];
                
                [self setEdge:self view:starPetView2 attr:NSLayoutAttributeTop constant:60];
                [self setEdge:self view:starPetView2 attr:NSLayoutAttributeLeft constant:20+80+20];
                
                [self setEdge:self view:add attr:NSLayoutAttributeTop constant:60];
                [self setEdge:self view:add attr:NSLayoutAttributeLeft constant:20+80+20+80+20];
                
            }
           
        }
            break;
            
        case controlStateNormal:
        {
            UILabel *notLoginTipsLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            notLoginTipsLabel.translatesAutoresizingMaskIntoConstraints=NO;
            notLoginTipsLabel.textAlignment = NSTextAlignmentLeft;
            notLoginTipsLabel.textColor = color_text;
            notLoginTipsLabel.font = defFont14;
            notLoginTipsLabel.text = notLoginTips;
            [self addSubview:notLoginTipsLabel];
            
            NSDictionary *viewDict = NSDictionaryOfVariableBindings(_lineView,notLoginTipsLabel);
            NSDictionary *metricDict = @{@"padding":@5,@"gap":@10};
            
            
            
            NSString*vhl1 = @"H:[notLoginTipsLabel]";
            NSString*vhl2 =@"V:[_lineView(1)][notLoginTipsLabel]";
            NSArray *vfls =@[vhl1,vhl2];
            
            [self addConstraints:[self addConstraintsWithVFL:vfls metric:metricDict views:viewDict]];
            
    
            [self addConstraint:[NSLayoutConstraint constraintWithItem:notLoginTipsLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_petListView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:notLoginTipsLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_petListView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        }
            break;
        default:
            break;
    }
}

- (void)controlClick:(id)sender{
    NSLog(@"%@",NSStringFromSelector(_cmd));
    NSNumber *num = sender;
    NSUInteger idx = num.integerValue;
    self.buttonClilkIndex(idx);
}

- (void)showPetsDetail{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}



- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents 
{
    _target=target;
    _act =action;
}


/**
 *  事件分发
 *
 *  @param touch
 *  @param event
 */
- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [touch locationInView:self];
    if (CGRectContainsPoint(_starPetLabel.frame, location)) {
         [self sendAction:_act to:_target forEvent:event];
    }
}


/**
 *  直接添加全部约束
 *
 *  @param vfls   约束语句
 *  @param metric 魔术字
 *  @param views  所有view
 *
 *  @return 返回所有约束
 */
- (NSArray*)addConstraintsWithVFL:(NSArray*)vfls metric:(NSDictionary*)metric views:(NSDictionary*)views{
    for (NSString*vfl in vfls) {
        [self.constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:vfl options:0 metrics:metric views:views]];
    }
    return self.constraints ;
}



/**
 *  设置边距
 *
 *  @param superview 父视图
 *  @param view      设定这个子视图到父视图的边距
 *  @param attr      上下左右
 *  @param constant
 */
- (void)setEdge:(UIView*)superview view:(UIView*)view attr:(NSLayoutAttribute)attr constant:(CGFloat)constant
{
    [superview addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:attr relatedBy:NSLayoutRelationEqual toItem:superview attribute:attr multiplier:1.0 constant:constant]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  BQStarPetControl.h
//  boqiimall
//
//  Created by 张正超 on 14/11/18.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  按钮点击事件代码块
 *
 *  @param intex 按钮的序号  按钮从左到右 为 0 1 2....
 */
typedef void(^buttonClickIndex)(NSUInteger intex);


/**
 状态枚举
 正常和未登录状态
 */
typedef enum controlState{
    controlStateNormal,
    controlStateNotLogin
} controlState;

@interface BQStarPetControl : UIControl


@property(nonatomic,readwrite,strong)buttonClickIndex buttonClilkIndex;
@property(nonatomic,readwrite,strong)NSMutableArray *petsDataSource;  //请求数据得到的宠物数据

@end

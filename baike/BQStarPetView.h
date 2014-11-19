//
//  BQStarPetView.h
//  boqiimall
//
//  Created by 张正超 on 14/11/18.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BQStarPetView : UIView

@property(nonatomic,readwrite,strong)UILabel*nameLabel;
@property(nonatomic,readwrite,strong)UIImage*image;

@property(nonatomic,readwrite,strong)id paramsObject; 
@property(nonatomic,readwrite,assign)id delegate;
@property(nonatomic,readwrite,assign)SEL selector;


@end

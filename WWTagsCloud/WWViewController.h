//
//  WWViewController.h
//  WWTagsCloud
//
//  Created by 张正超 on 14-7-25.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WWTagsCloudView.h"
@interface WWViewController : UIViewController<WWTagsCloudViewDelegate>
- (IBAction)refreshBtnClick:(id)sender;

@end

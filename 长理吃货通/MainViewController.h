//
//  MainViewController.h
//  长理吃货通
//
//  Created by pandaharry on 14-5-12.
//  Copyright (c) 2014年 pandaharry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainViewController : UIViewController <UIActionSheetDelegate>
@property (strong, nonatomic) IBOutlet UIButton *LocationLabel;
@property (strong, nonatomic) IBOutlet UIButton *TypeLabel;
- (IBAction)LocationButton:(UIButton *)sender;
- (IBAction)TypeButton:(UIButton *)sender;
- (IBAction)ChooseButton:(UIButton *)sender;
@property (strong,nonatomic) NSMutableArray *restaurants;
@property (strong,nonatomic) NSManagedObject *lastRestaurant;
@property (strong, nonatomic) IBOutlet UILabel *ResultLabel;

@end

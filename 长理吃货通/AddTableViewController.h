//
//  AddTableViewController.h
//  长理吃货通
//
//  Created by pandaharry on 14-5-5.
//  Copyright (c) 2014年 pandaharry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTableViewController : UITableViewController <UIActionSheetDelegate,UITextFieldDelegate>
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)save:(UIBarButtonItem *)sender;

@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *rateLabel;
@property (strong, nonatomic) IBOutlet UITextField *nameLabel;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property BOOL nameState;
@property BOOL locationState;
@property BOOL typeState;
@property BOOL rateState;

@end

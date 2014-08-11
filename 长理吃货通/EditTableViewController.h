//
//  EditTableViewController.h
//  长理吃货通
//
//  Created by pandaharry on 14-5-11.
//  Copyright (c) 2014年 pandaharry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditTableViewController : UITableViewController <UIActionSheetDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *rateLabel;
@property (strong,nonatomic) NSManagedObject *MyRestaurant;
@property (strong,nonatomic) NSManagedObject *restaurant;
- (IBAction)save:(UIBarButtonItem *)sender;
- (IBAction)cancel:(UIBarButtonItem *)sender;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (strong,nonatomic) UITapGestureRecognizer *tapGesture;


@end

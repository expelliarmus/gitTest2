//
//  AddRestaurantViewController.h
//  长理吃货通
//
//  Created by pandaharry on 14-4-27.
//  Copyright (c) 2014年 pandaharry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRestaurantViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *locationTF;
@property (weak, nonatomic) IBOutlet UITextField *typeTF;
@property (weak, nonatomic) IBOutlet UITextField *rateTF;


@end

//
//  RestaurantsTableViewController.h
//  长理吃货通
//
//  Created by pandaharry on 14-4-27.
//  Copyright (c) 2014年 pandaharry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RestaurantsTableViewController : UITableViewController
@property (strong,nonatomic) NSMutableArray *restaurants;
@property (strong,nonatomic) NSManagedObject *restaurant;
@end

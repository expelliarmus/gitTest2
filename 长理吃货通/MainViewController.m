//
//  MainViewController.m
//  长理吃货通
//
//  Created by pandaharry on 14-5-12.
//  Copyright (c) 2014年 pandaharry. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIColor *tintColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    self.LocationLabel.layer.borderWidth=0.7f;
    self.LocationLabel.layer.borderColor=[tintColor CGColor];
    self.LocationLabel.layer.cornerRadius=4;
    self.TypeLabel.layer.borderWidth=0.7f;
    self.TypeLabel.layer.borderColor=[tintColor CGColor];
    self.TypeLabel.layer.cornerRadius=4;
    // Do any additional setup after loading the view.
}

-(void) portraitLock {
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    appDelegate.screenIsPortraitOnly = true;
}

#pragma mark - interface posiiton

- (NSUInteger) application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL) shouldAutorotate {
    return NO;
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self portraitLock];
    self.lastRestaurant = nil;
    self.ResultLabel.text = @"去哪吃？";
    
}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

- (IBAction)LocationButton:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"地点" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全部", @"南门", @"西门", @"东门", @"校园", nil];
    [actionSheet setTag: 0];
    [actionSheet showInView:self.view];
}
- (IBAction)TypeButton:(UIButton *)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"全部", @"米饭", @"粉面", @"西餐", @"其他", nil];
    [actionSheet setTag: 1];
    [actionSheet showInView:self.view];
}

- (IBAction)ChooseButton:(UIButton *)sender {
 
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Restaurants"];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"rate" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    if ([self.LocationLabel.titleLabel.text isEqualToString:@"全部"]&&[self.TypeLabel.titleLabel.text isEqualToString:@"全部"]) {
       self.restaurants = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    }
    else if (![self.LocationLabel.titleLabel.text isEqualToString:@"全部"]&&![self.TypeLabel.titleLabel.text isEqualToString:@"全部"])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"location = %@ AND type = %@",self.LocationLabel.titleLabel.text,self.TypeLabel.titleLabel.text];
        [fetchRequest setPredicate:predicate];
        self.restaurants = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    }
    else if (![self.LocationLabel.titleLabel.text isEqualToString:@"全部"]&&[self.TypeLabel.titleLabel.text isEqualToString:@"全部"])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"location = %@",self.LocationLabel.titleLabel.text];
        [fetchRequest setPredicate:predicate];
        self.restaurants = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    }
    else if ([self.LocationLabel.titleLabel.text isEqualToString:@"全部"]&&![self.TypeLabel.titleLabel.text isEqualToString:@"全部"])
    {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@",self.TypeLabel.titleLabel.text];
        [fetchRequest setPredicate:predicate];
        self.restaurants = [[managedObjectContext executeFetchRequest:fetchRequest error:nil] mutableCopy];
    }
    
    if (self.restaurants.count) {
        if (self.restaurants.count>1) {
            [self.restaurants removeObject:self.lastRestaurant];
        }else{
        }
        
        NSManagedObject *restaurant = [self.restaurants objectAtIndex:self.restaurants.count-1];
        NSString *highestRateString = [restaurant valueForKey:@"rate"];
        NSInteger highestRate = [highestRateString integerValue];
        NSLog(@"%ld",(long)highestRate);
        if (highestRate > 0) {
            NSInteger randomIndex = arc4random() % self.restaurants.count;
            NSInteger weight = arc4random() % highestRate;
            NSInteger chosenRate =[[[self.restaurants objectAtIndex:randomIndex] valueForKey:@"rate"] integerValue];
            while (weight >= chosenRate) {
                randomIndex = arc4random() % self.restaurants.count;
                chosenRate = [[[self.restaurants objectAtIndex:randomIndex] valueForKey:@"rate"] integerValue];            }
            NSString *chosenRestaurant = [[self.restaurants objectAtIndex:randomIndex] valueForKey:@"name"];
            self.lastRestaurant = [self.restaurants objectAtIndex:randomIndex];
            self.ResultLabel.text = chosenRestaurant;            NSLog(@"%@",chosenRestaurant);
        }
        else {
            self.ResultLabel.text = @"无结果";
            NSLog(@"Not Found 2");
        }
    }
    else {
        NSLog(@"Not Found");
        self.ResultLabel.text = @"无结果";
    }
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (actionSheet.tag)
    {
        case 0: //LocationSheet
        {
            switch (buttonIndex)
            {
                case 0: //1st button
                [self.LocationLabel setTitle: @"全部" forState: UIControlStateNormal];
                    break;
                case 1:
                [self.LocationLabel setTitle: @"南门" forState: UIControlStateNormal];
                    break;
                case 2:
                [self.LocationLabel setTitle: @"西门" forState: UIControlStateNormal];
                    break;
                case 3:
                [self.LocationLabel setTitle: @"东门" forState: UIControlStateNormal];
                    break;
                case 4:
                [self.LocationLabel setTitle: @"校园" forState: UIControlStateNormal];
                    break;
            }
            
        }
            break;
        case 1: //typeSheet
        {
            switch (buttonIndex)
            {
                case 0: //1st button
                [self.TypeLabel setTitle: @"全部" forState: UIControlStateNormal];
                    break;
                case 1:
                [self.TypeLabel setTitle: @"米饭" forState: UIControlStateNormal];
                    break;
                case 2:
                [self.TypeLabel setTitle: @"粉面" forState: UIControlStateNormal];
                    break;
                case 3:
                [self.TypeLabel setTitle: @"西餐" forState: UIControlStateNormal];
                    break;
                case 4:
                [self.TypeLabel setTitle: @"其他" forState: UIControlStateNormal];
                    break;
            }
        }
            break;
    }
    self.ResultLabel.text = @"去哪吃？";
}

@end

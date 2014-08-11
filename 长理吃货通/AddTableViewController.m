//
//  AddTableViewController.m
//  长理吃货通
//
//  Created by pandaharry on 14-5-5.
//  Copyright (c) 2014年 pandaharry. All rights reserved.
//

#import "AddTableViewController.h"

@interface AddTableViewController ()

@end

@implementation AddTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.saveButton.enabled = NO;
    self.nameState = NO;
    self.locationState = NO;
    self.typeState = NO;
    self.rateState = NO;
    
    [self.nameLabel setDelegate:self];
    [self.nameLabel becomeFirstResponder];    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeRight:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.tableView addGestureRecognizer:recognizer];
    

    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //Eliminate
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)dismissKeyboard
{
    [self.nameLabel endEditing:YES];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.nameState = NO;
    [self checkState];
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:self.tapGesture];
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimWhiteSpace = [textField.text stringByTrimmingCharactersInSet:whiteSpace];
    if (trimWhiteSpace.length>0) {
        self.nameState = YES;
        [self checkState];
    }
    [self.view removeGestureRecognizer:self.tapGesture];
}

-(void)checkState
{
    if (self.nameState && self.locationState && self.typeState && self.rateState) {
        self.saveButton.enabled = YES;
    }
    else
    {
        self.saveButton.enabled = NO;
    }
}

- (void)SwipeRight:(UISwipeGestureRecognizer *)gestureRecognizer
{
    [self.navigationController popViewControllerAnimated:YES];
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

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newRestaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurants" inManagedObjectContext:context];
    [newRestaurant setValue:self.nameLabel.text forKey:@"name"];
    [newRestaurant setValue:self.locationLabel.text forKey:@"location"];
    [newRestaurant setValue:self.typeLabel.text forKey:@"type"];
    [newRestaurant setValue:self.rateLabel.text forKey:@"rate"];
    NSError *error = nil;
    
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
[self.navigationController popViewControllerAnimated:YES];    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    int rowint = (int)row;
    switch (rowint) {
        case 1: {
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"地点" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"南门", @"西门", @"东门", @"校园", nil];
            [actionSheet setTag: 0];               [actionSheet showInView:self.view];          break;
        }
            
        case 2:{
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"类型" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"米饭", @"粉面", @"西餐", @"其他", nil];
            [actionSheet setTag: 1];          [actionSheet showInView:self.view];          break;
        }
            
        case 3:{
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"评分" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"0分", @"1分", @"2分", @"3分", @"4分", @"5分",nil];
            [actionSheet setTag: 2];               [actionSheet showInView:self.view];          break;
        }
        default:
            break;
    }

[tableView deselectRowAtIndexPath:indexPath animated:YES];
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
                    {self.locationLabel.text = @"南门";}
                    break;
                case 1:
                    {self.locationLabel.text = @"西门";}
                    break;
                case 2:
                    {self.locationLabel.text = @"东门";}
                    break;
                case 3:
                    {self.locationLabel.text = @"校园";}
                    break;
            }
            if (buttonIndex>=0 && buttonIndex <=3) {
                self.locationState = YES;
                [self checkState];
            }
        }
            break;
        case 1: //typeSheet
        {
            switch (buttonIndex)
            {
                case 0: //1st button
                {self.typeLabel.text = @"米饭";}
                    break;
                case 1:
                {self.typeLabel.text = @"粉面";}
                    break;
                case 2:
                {self.typeLabel.text = @"西餐";}
                    break;
                case 3:
                {self.typeLabel.text = @"其他";}
                    break;
            }
            if (buttonIndex>=0 && buttonIndex <=3) {
                self.typeState = YES;
                [self checkState];
            }
        }
            break;
            
        case 2://ratesheet
        {
            switch (buttonIndex)
            {
                case 0: //1st button
                {self.rateLabel.text = @"0分";}
                    break;
                case 1:
                {self.rateLabel.text = @"1分";}
                    break;
                case 2:
                {self.rateLabel.text = @"2分";}
                    break;
                case 3:
                {self.rateLabel.text = @"3分";}
                    break;
                case 4:
                {self.rateLabel.text = @"4分";}
                    break;
                case 5:
                {self.rateLabel.text = @"5分";}
                break;
            }
            if (buttonIndex>=0 && buttonIndex <=5) {
                self.rateState = YES;
                [self checkState];
            }
        }
        break;
    }
}
@end

//
//  EditTableViewController.m
//  长理吃货通
//
//  Created by pandaharry on 14-5-11.
//  Copyright (c) 2014年 pandaharry. All rights reserved.
//

#import "EditTableViewController.h"

@interface EditTableViewController ()

@end

@implementation EditTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(SwipeLeft:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.tableView addGestureRecognizer:recognizer];
    
    
    [self.nameLabel setDelegate:self];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Restaurants" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self == %@", self.MyRestaurant];
    [fetchRequest setPredicate:predicate];
    self.restaurant = [[context executeFetchRequest:fetchRequest error:nil] objectAtIndex:0];
        self.nameLabel.text = [self.restaurant valueForKey:@"name"];
        self.locationLabel.text = [self.restaurant valueForKey:@"location"];
        self.typeLabel.text = [self.restaurant valueForKey:@"type"];
        self.rateLabel.text = [self.restaurant valueForKey:@"rate"];
        
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
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    
    if (![[touch view] isKindOfClass:[UITextField class]]) {
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.saveButton.enabled = NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimWhiteSpace = [textField.text stringByTrimmingCharactersInSet:whiteSpace];
    if (trimWhiteSpace.length>0) {
        self.saveButton.enabled = YES;
    }
    else {
        self.saveButton.enabled = NO;
    }

}


- (void)SwipeLeft:(UISwipeGestureRecognizer *)gestureRecognizer
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


- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    [theTextField resignFirstResponder];
    return YES;
}

- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    NSManagedObjectContext *context = [self managedObjectContext];
    

    [self.restaurant setValue:self.nameLabel.text forKey:@"name"];
    [self.restaurant setValue:self.locationLabel.text forKey:@"location"];
    [self.restaurant setValue:self.typeLabel.text forKey:@"type"];
    [self.restaurant setValue:self.rateLabel.text forKey:@"rate"];
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
        }
            break;
    }
}
@end

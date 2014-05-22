//
//  ObjTableViewController.h
//  Demo
//
//  Created by MARK GALLEN on 5/22/14.
//  Copyright (c) 2014 Double Encore. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ObjTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *objBooks;
@property(strong, nonatomic) NSMutableArray *listOfBooks;
@end

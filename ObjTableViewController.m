//
//  ObjTableViewController.m
//  Demo
//
//  Created by MARK GALLEN on 5/22/14.
//  Copyright (c) 2014 Double Encore. All rights reserved.
//

#import "ObjTableViewController.h"
#import "JSONObjects.h"
#import "LoadJSON.h"

@implementation ObjTableViewController
@synthesize listOfBooks;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Load JSON Objects - The list is not just books :(
    [self loadJSONObjects];
}

- (void)loadJSONObjects
{
    listOfBooks = nil;
    
    //TODO: Expand to make reusuable with user configs?
    NSString* JSONURL = @"http://de-coding-test.s3.amazonaws.com/books.json";
    
    //Use queue for JSON call
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        NSDictionary * dictionary = [LoadJSON loadJSONData:JSONURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            listOfBooks = [NSMutableArray array];
            
            int Count = 1;
 
            //TODO: Add tabbed and more view buttons ... added limit to speed up execution.
            while ( Count < 10)
            {
                for (NSDictionary * aObject in dictionary)
                {
                    JSONObjects* JSONObj = [[JSONObjects alloc] init];
                    JSONObj.Title = [aObject objectForKey:@"title"];
                    JSONObj.Author = [aObject objectForKey:@"author"];
                    //Fixed at last minute, was missing URL
                    JSONObj.ImageURL = [aObject objectForKey:@"imageURL"];
                    [listOfBooks addObject:JSONObj];
                    Count = Count + 1;
                }
            }
        });

        
            dispatch_async(dispatch_get_main_queue(), ^{[self.tableView reloadData];});
        });
        
    };
    
//Put in sections eventually

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return listOfBooks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"ObjListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    JSONObjects* JSONObj = [listOfBooks objectAtIndex:indexPath .row];
    
    //TODO: Format?, Filter non-books?
    cell.textLabel.text = JSONObj.Title;
    cell.detailTextLabel.text = JSONObj.Author;
    NSData *imagedata = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:JSONObj.ImageURL]];
    UIImage* image = [[UIImage alloc] initWithData:imagedata];
    cell.imageView.image = image;
    return cell;
}

@end

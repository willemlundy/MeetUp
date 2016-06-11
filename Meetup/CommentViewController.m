//
//  CommentViewController.m
//  Meetup
//
//  Created by William Lundy on 10/12/15.
//  Copyright © 2015 William Lundy. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Use the meetup passed in to get the event ID
    NSString *eventID = [NSString stringWithFormat:@"%@", [self.meetup objectForKey:@"id"]];
    
    // Build the URL string
    NSString *urlString = [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?offset=0&format=json&event_id=%@&key=2a73e5e6f7f57437453f5335403774", eventID];
    
    // Create the URL
    NSURL *url = [NSURL URLWithString:urlString];
    NSError *error;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.comments = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [task resume];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    
    NSDictionary *comment = [[self.comments objectForKey:@"results"] objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = [comment objectForKey:@"name"];
    //cell.detailTextLabel.text = [[comment objectForKey:@"venue"] objectForKey:@"address_1"];
    
    
    return cell;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.comments objectForKey:@"results"] count];
}


@end

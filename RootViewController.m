//
//  RootViewController.m
//  Meetup
//
//  Created by William Lundy on 10/12/15.
//  Copyright © 2015 William Lundy. All rights reserved.
//

#import "RootViewController.h"
#import "DetailViewController.h"

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@property NSDictionary *meetups;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"https://api.meetup.com/2/open_events.json?zip=94131&text=mobile&time=,1w&key=2a73e5e6f7f57437453f5335403774"];
    NSError *error;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.meetups = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
    [task resume];
    
}

- (void)searchForString:(NSString *)searchString
{
    
    NSString *webSearchString = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=94131&text=%@&time=,1w&key=2a73e5e6f7f57437453f5335403774", searchString];
    
    NSURL *url = [NSURL URLWithString:webSearchString];
    NSError *error;
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        self.meetups = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeetupCell"];
    NSDictionary *meetup = [[self.meetups objectForKey:@"results"] objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = [meetup objectForKey:@"name"];
    cell.detailTextLabel.text = [[meetup objectForKey:@"venue"] objectForKey:@"address_1"];
    
//    NSURL *url = [NSURL URLWithString:meetup[@"avatar_url"]];
//    
//    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.imageView.image = [UIImage imageWithData:data];
//            [cell layoutSubviews];
//        });
//    }];
    
//    [task resume];
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.meetups objectForKey:@"results"] count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the Destination View Controller
    DetailViewController *dvc = segue.destinationViewController;
    
    // Get the index path of the selected row
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    // Make a dictionary for the meetup
    NSDictionary *meetup = [[self.meetups objectForKey:@"results"] objectAtIndex:indexPath.row];
    
    
    //NSLog(@"%@", meetup);
    // Pass the meetup to the detail view controller
    dvc.meetup = meetup;
    
    
}
- (IBAction)onSearchButtonPressed:(UIButton *)sender {
    [self searchForString:self.searchTextField.text];
    [self.tableView reloadData];
}


@end


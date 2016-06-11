//
//  DetailViewController.m
//  Meetup
//
//  Created by William Lundy on 10/12/15.
//  Copyright © 2015 William Lundy. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "CommentViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *groupName;
@property (weak, nonatomic) IBOutlet UILabel *groupCount;
@property (weak, nonatomic) IBOutlet UILabel *hostingGroup;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupName.text = [self.meetup objectForKey:@"name"];
    self.groupCount.text = [NSString stringWithFormat:@"Count: %@", [self.meetup objectForKey:@"yes_rsvp_count"]];
    self.hostingGroup.text = [NSString stringWithFormat:@"Group: %@", [[self.meetup objectForKey:@"group"] objectForKey:@"name"]]
    ;
    [self.webView loadHTMLString:[self.meetup objectForKey:@"description"] baseURL:nil];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"WebViewControllerSegue"])
    {
        
        WebViewController *wvc = segue.destinationViewController;
        
        wvc.webString = [self.meetup objectForKey:@"event_url"];
    }
    if ([segue.identifier isEqualToString:@"CommentViewControllerSegue"])
    {
        
        CommentViewController *cvc = segue.destinationViewController;
        
        cvc.meetup = self.meetup;
    }
    
}

@end

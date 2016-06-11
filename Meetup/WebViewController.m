//
//  WebViewController.m
//  Meetup
//
//  Created by William Lundy on 10/12/15.
//  Copyright © 2015 William Lundy. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.webString = @"http://www.google.com";
    
    self.webView.delegate = self;
    NSLog(@"%@", self.webString);
    [self loadPage:self.webString];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadPage:(NSString *)webStr
{
    
    NSURL *url = [NSURL URLWithString:webStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.spinner startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // Enable or Disable back button
    [self.backButton setEnabled:[self.webView canGoBack]];
    
    // Enable or Disable forward button
    [self.forwardButton setEnabled:[self.webView canGoForward]];
    
    
    [self.spinner stopAnimating];
    
  
}
- (IBAction)onBackButtonPressed:(UIButton *)sender
{
    
    [self.webView goBack];
    
}
- (IBAction)onForwardButtonPressed:(UIButton *)sender
{
    
    [self.webView goForward];
    
}


@end

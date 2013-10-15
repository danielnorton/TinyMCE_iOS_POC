//
//  BRViewController.m
//  TinyMceOne
//
//  Created by Daniel Norton on 10/14/13.
//  Copyright (c) 2013 Daniel Norton. All rights reserved.
//

#import "BRViewController.h"
#import "BRTextViewController.h"


@interface BRViewController()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BRViewController


#pragma mark UIViewController
- (void)viewDidLoad {

	NSURL *url = [NSURL URLWithString:@"http://localhost:8888/root.html"];
	NSData *htmlData = [NSData dataWithContentsOfURL:url];
	if (htmlData) {
		[_webView loadData:htmlData
				  MIMEType:@"text/html"
		  textEncodingName:@"UTF-8"
				   baseURL:url];
	}
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	BRTextViewController *controller = (BRTextViewController *)segue.destinationViewController;
	NSString *html = [_webView stringByEvaluatingJavaScriptFromString:@"getContent();"];
	[controller setText:html];
}


#pragma mark UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

	if (navigationType == UIWebViewNavigationTypeLinkClicked) {
		
		[[UIApplication sharedApplication] openURL:request.URL];
		return NO;
	}
	return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
	
	NSString *message = [error localizedDescription];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
													message:message
												   delegate:nil
										  cancelButtonTitle:@"Done"
										  otherButtonTitles:nil];
	[alert show];
}

- (IBAction)didTapEdit:(UIBarButtonItem *)sender {
	
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"html"];
	NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
	NSString *html = [[NSString alloc] initWithData:htmlData encoding:NSUTF8StringEncoding];
	html = [html stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
	html = [html stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
	
	NSString *content = [NSString stringWithFormat:@"setContent('%@')", html];
	[_webView stringByEvaluatingJavaScriptFromString:content];
}

@end

//
//  CustomNavigationBar.m
//  Pokemon
//
//  Created by Kaijie Yu on 2/2/12.
//  Copyright (c) 2012 Kjuly. All rights reserved.
//

#import "CustomNavigationBar.h"

@implementation CustomNavigationBar

@synthesize navigationController         = navigationController_;
@synthesize navigationBarBackgroundImage = navigationBarBackgroundImage_;
@synthesize backButton                   = backButton_;

-(void)dealloc
{
  [navigationController_         release];
  [navigationBarBackgroundImage_ release];
  [backButton_                   release];
  
  [super dealloc];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//
// If we have a custom background image, then draw it,
// othwerwise call super and draw the standard nav bar
- (void)drawRect:(CGRect)rect
{
  NSLog(@"*** CustomNavigationBar drawRect:");
  
  // Draw |navigationBarBackgroundImage_|
  if (navigationBarBackgroundImage_)
    [navigationBarBackgroundImage_.image drawInRect:navigationBarBackgroundImage_.frame];
  else
    [super drawRect:rect];
  
  // Create custom |backButton_|
  [self resetBackButton];
}

// Reset NavigationBar's size to container |navigationBarBackgroundImage_|
// 
////TODO: for Device Orientation:
//
//  UIInterfaceOrientation orientation = (UIInterfaceOrientation)[[UIDevice currentDevice] orientation];
//  float newSizeWidth;
//  if ( UIInterfaceOrientationIsLandscape(orientation) ) newSizeWidth = 480.0f;
//  else newSizeWidth = 320.0f;
//  CGSize newSize = CGSizeMake(newSizeWidth, navigationBarBackgroundImage_.frame.size.height);
//  NSLog(@">>> new size: (%f, %f)", newSize.width, newSize.height);
//  return newSize;
//
- (CGSize)sizeThatFits:(CGSize)size {
  return self.navigationBarBackgroundImage.frame.size;
}

// Save the background image to |navigationBarBackgroundImage_|,
// If not shown, call |[self setNeedsDisplay];| to force a redraw.
- (void)initNavigationBarWith:(UIImage *)backgroundImage
{
  navigationBarBackgroundImage_ = [[UIImageView alloc]
                                   initWithFrame:CGRectMake(0.0f,
                                                            0.0f,
                                                            backgroundImage.size.width,
                                                            backgroundImage.size.height)];
  navigationBarBackgroundImage_.image = backgroundImage;
}

// Settings for |backButton|
// Provide the action for the custom |backButton|
- (void)back:(id)sender {
  NSLog(@"popViewController");
  [self.navigationController popViewControllerAnimated:YES];
}

// Reset |backButton|
- (void)resetBackButton
{
  if (! self.backButton) {
    UIImage * backButtonImage = [UIImage imageNamed:@"CustomNavigationBar_backButton.png"];
    backButton_ = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, backButtonImage.size.width, backButtonImage.size.height)];
    [backButton_ setImage:backButtonImage forState:UIControlStateNormal];
    [backButton_ addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
  }
  [self addSubview:self.backButton];
}

/*- (void)setBackButtonWith:(UINavigationItem *)navigationItem
{
  NSLog(@"--- CustomNavigationBar setBackButtonWith: ---");
  
//  {
//    UIButton * backButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 60.0f, 40.0f)];
//    [backButton setTitle:@"<<" forState:UIControlStateNormal];
//    [backButton setBackgroundColor:[UIColor yellowColor]];
//    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [backButton setUserInteractionEnabled:YES];
//    
//    UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
//    [backBarButtonItem setEnabled:YES];
//    [backButton release];
//    
//    [navigationItem setLeftBarButtonItem:backBarButtonItem];
//    [backBarButtonItem release];
//  }
  
  [self setNeedsDisplay];
}*/

// clear the background image and call setNeedsDisplay to force a redraw
- (void)clearBackground
{
  self.navigationBarBackgroundImage = nil;
  self.backButton                   = nil;
  
  [self setNeedsDisplay];
}

@end
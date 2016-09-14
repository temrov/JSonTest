//
//  FCJSonRequest.m
//  JSonTest
//
//  Created by user01 on 14.09.16.
//  Copyright © 2016 user01. All rights reserved.
//

#import "FCJSonRequest.h"
#import "FCImage.h"
#import <RestKit/RestKit.h>




@implementation FCJSonRequest
-(void)configure {
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://web-api.ifunny.mobi"];
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    RKMapping* pictureMapping = [FCImageMapping get];
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pictureMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"/ifunny/v1/feeds/featured"
                                                keyPath:@"content.items"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    
    [objectManager addResponseDescriptor:responseDescriptor];
}
-(void)loadItems {
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/ifunny/v1/feeds/featured"
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  NSArray* gotItems = mappingResult.array;
                                                  
                                                  NSLog(@"Success getting %lu visual items", (unsigned long)gotItems.count);
                                                  for(FCVisualItem* visItem in gotItems) {
                                                      if (![visItem.type  isEqual: @"pic"]) {
                                                          NSLog(@"got item of type %@. Why???", visItem.type);
                                                          return;
                                                      }
                                                  }
                                                  NSLog(@"All of them are pictures");
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"What do you mean by 'there is no pics?': %@", error);
                                              }];
}
@end

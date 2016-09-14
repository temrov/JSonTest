//
//  FCImage.h
//  JSonTest
//
//  Created by user01 on 14.09.16.
//  Copyright © 2016 user01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FCVisualItem.h"


@interface FCImage : FCVisualItem


@end


@interface FCImageMapping : RKObjectMapping
+(RKMapping*)get;
@end


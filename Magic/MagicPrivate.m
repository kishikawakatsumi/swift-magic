//
//  MagicPrivate.m
//  Magic
//
//  Created by Kishikawa Katsumi on 2018/12/23.
//  Copyright © 2018 Kishikawa Katsumi. All rights reserved.
//

#import "MagicPrivate.h"
#import <magic.h>

@implementation MagicPrivate

- (instancetype)init {
    self = [super init];
    if (self) {
        magic_open(MAGIC_NONE);
    }
    return self;
}

@end

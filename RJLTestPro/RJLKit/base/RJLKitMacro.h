//
//  RJLKitMacro.h
//  RJLTestPro
//
//  Created by mini on 16/9/20.
//  Copyright © 2016年 renjialiang. All rights reserved.
//

#ifndef RJLKitMacro_h
#define RJLKitMacro_h

/**
 Add this macro before each category implementation, so we don't have to use
 -all_load or -force_load to load object files from static libraries that only
 contain categories and no classes.
 More info: http://developer.apple.com/library/mac/#qa/qa2006/qa1490.html .
 *******************************************************************************
 Example:
 RJLSYNTH_DUMMY_CLASS(NSString_RJLAdd)
 */
#ifndef RJLSYNTH_DUMMY_CLASS
#define RJLSYNTH_DUMMY_CLASS(_name_) \
@interface RJLSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation RJLSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif
#endif /* RJLKitMacro_h */

#import <Foundation/Foundation.h>

@interface PGApp : NSObject

+ (int)generateWithInputPath:(NSString *)inputPath
               outPutDirPath:(NSString *)outPutDirPath
            outPutParserName:(NSString *)parserName;

@end
#import <Foundation/Foundation.h>
#import "PGDocument.h"
#import "PGApp.h"

int main(int argc, const char *argv[]) {
    if (argc < 4) {
        NSLog(@"Usage : ./ParserGenCmd [input_path] [output_dir_path] [parser_name]");
        return 1;
    }

    int res;
    @autoreleasepool {
        NSString *inputPath = [NSString stringWithUTF8String:argv[1]];
        NSString *outputDirPath = [NSString stringWithUTF8String:argv[2]];
        NSString *parserName = [NSString stringWithUTF8String:argv[3]];

        char *currentDirPathStr = malloc(100);
        NSString *currentDirPath = [NSString stringWithUTF8String:getcwd(currentDirPathStr, 100)];
        free(currentDirPathStr);

        if (![inputPath hasPrefix:@"/"]) {
            inputPath = [currentDirPath stringByAppendingPathComponent:inputPath];
        }

        if (![outputDirPath hasPrefix:@"/"]) {
            outputDirPath = [currentDirPath stringByAppendingPathComponent:outputDirPath];
        }

        res = [PGApp generateWithInputPath:inputPath
                             outPutDirPath:outputDirPath
                          outPutParserName:parserName];
    }
    return res;
}

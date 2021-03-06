#import <PEGKit/PKParser.h>

enum {
    CSS_TOKEN_KIND_COMMA = 14,
    CSS_TOKEN_KIND_COLON = 15,
    CSS_TOKEN_KIND_TILDE = 16,
    CSS_TOKEN_KIND_SEMI = 17,
    CSS_TOKEN_KIND_DOT = 18,
    CSS_TOKEN_KIND_BANG = 19,
    CSS_TOKEN_KIND_FWDSLASH = 20,
    CSS_TOKEN_KIND_EQ = 21,
    CSS_TOKEN_KIND_GT = 22,
    CSS_TOKEN_KIND_HASH = 23,
    CSS_TOKEN_KIND_OPENBRACKET = 24,
    CSS_TOKEN_KIND_AT = 25,
    CSS_TOKEN_KIND_CLOSEBRACKET = 26,
    CSS_TOKEN_KIND_OPENPAREN = 27,
    CSS_TOKEN_KIND_OPENCURLY = 28,
    CSS_TOKEN_KIND_URLUPPER = 29,
    CSS_TOKEN_KIND_URLLOWER = 30,
    CSS_TOKEN_KIND_PIPE = 31,
    CSS_TOKEN_KIND_CLOSEPAREN = 32,
    CSS_TOKEN_KIND_CLOSECURLY = 33,
};

@interface CSSParser : PKParser

@end


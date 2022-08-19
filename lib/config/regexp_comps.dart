RegExp blogShortRegexpComp =
    RegExp(r'(^\/blog\/)', multiLine: true, caseSensitive: true);
String blogShortText = "/blog/";

RegExp blogLongRegexpComp = RegExp(r'(^https:\/\/go\.dev\/blog\/)',
    multiLine: true, caseSensitive: true);
String blogLongText = "https://go.dev/blog/";

RegExp oldBlogLongRegexpComp = RegExp(r'(^https:\/\/blog\.golang\.org\/)',
    multiLine: true, caseSensitive: true);
String oldBlogLongText = "https://blog.golang.org/";

RegExp startsWithHTTP =
    RegExp(r'(^http)', multiLine: true, caseSensitive: true);

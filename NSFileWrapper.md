Store Multiple Types of Data in a Single File Using NSFileWrapper in iOS  
========================================================================
In many iOS application development projects, we have requirement to store the data. We can store it in many ways, like in database or as a file storage in a document file. And if we have multiple types of data like text and image, we are storing them as different entities.

But can we store them as a single file? Yes, we can and here comes the NSFileWrapper to the rescue.

NSFileWrapper is a class that provides access to the contents of a file, directory or symbolic link. Using this class, multiple types of content can be saved as a single document and it can be loaded independently.

For example, if we have text and image then we can save them in a single document using NSFileWrapper and we can also extract image and text separately from it excluding the need to load the whole document.

Instances of NSFileWrapper is called file wrappers. They represent the file or directory as an object that can be displayed as image, can be saved to file system or even transmitted to another application.

There are 3 types of file wrappers,

1) Regular-file file wrapper

It contains the contents of a single actual file.

2) Directory file wrapper

It contains a directory and all the files and sub directories of that directory.

3) Symbolic-link file wrapper

It represents a symbolic link in the file system.

Now let’s see how we can use NSFileWrapper to save and load content of a document.

Consider we have to store text and an image in the document. So first we have to use subclass UIDocument which will deal with data saving into and fetching from NSFileWrapper.

In this class, we have to override 2 methods of UIDocument class.

![]()  
![]()  

Here is the implementation of these methods,

  
```   
- (id)contentsForType:(NSString *)typeName error:(NSError **)outError {
 
NSFileWrapper *contents = [[NSFileWrapperalloc] initDirectoryWithFileWrappers:nil];
 
// this is the text we want to save
NSString * textString = @"This is a test data";
NSData *textData = [textString dataUsingEncoding:NSUTF8StringEncoding];
 
NSFileWrapper *txtWrapper = [[NSFileWrapperalloc] initRegularFileWithContents:textData];
[txtWrapper setPreferredFilename:@"data.txt"];
[contents addFileWrapper:txtWrapper];
 
// this is the image we want to save
UIImage * image = [UIImageimageNamed:@"xyz.png"];
NSData *imageData = UIImagePNGRepresentation(image);
NSFileWrapper * imgWrapper = [[NSFileWrapperalloc] initRegularFileWithContents:imageData];
[imgWrapper setPreferredFilename:@"image.png"];
[contents addFileWrapper:imgWrapper];\
 
return contents;
}   
```

This method will be called when we are saving a document. In this method, the content of the document which we want to save should be returned.

Here we want to save an image “xyz.png” and text in the document. So to store this multiple content we will create NSFileWrapper of type directory which will store image and text as file attributes. Create file wrapper for both text and image of type regular file and using method addFileWrapper: add the wrapper to the directory wrapper. We can also set name of the file wrappers to identify the data.

Now lets check that how we can read the contents of the document.

```  
- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError **)outError {
 
NSFileWrapper *contentWrapper = (NSFileWrapper *)contents;
 
NSFileWrapper *textWrapper = [[contentWrapper fileWrappers] objectForKey:@"data.txt"];
NSData *textData = [textWrapper regularFileContents];
 
// text from the document
NSString * textOfDocument = [[NSStringalloc] initWithData:textData encoding:NSUTF8StringEncoding];
NSFileWrapper *imageWrapper = [[contentWrapper fileWrappers] objectForKey:@"image.png"];
NSData *imageData = [imageWrapper regularFileContents];
// image from the document
UIImage * image = [UIImageimageWithData:imageData];
 
return YES;
}  
```  
This method will be called when we open a document. This method gives the contents of the document as the parameter and if we have stored content using NSFileWrapper in this document, then this method will return content in form of NSFileWrapper.

The method [contentWrapper fileWrappers] will return the filewrapper in the form of directory from which we can fetch the data from the assigned key, like we have assign the text data key as “data.txt” and for image “image.png”. So we can read only that much data that we want to and for that we don’t have to read whole document.

So, NSFileWrapper is a good solution when we want to store multiple files as a single document and can read each file individually. We can easily store multiple types of data that can be text, image or any object class using the file wrapper and it can be easily accessed.

This is all I have from my side for now, please feel free to share your feedback if you would like to share anything. We would love to hear it.



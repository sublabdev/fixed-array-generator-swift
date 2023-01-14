# Fixed Size Array generator for Swift

Small macOS utility to build fixed size arrays of any size in Swift.

Creates files with file name as *ArrayX.swift* where X is size of the array.
All arrays are implemented as *@propertyWrapper* and throw an error if upon write the actual size is different from fixed one.

Also creates the Test file which tests all types encoding/decoding using [Swift Scale Codec](https://github.com/sublabdev/scale-codec-swift).
Feel free to change anything for your purpose.

# Usage

Run next command in your terminal:

    ./ScaleCodecFixedArrayGenerator 256 ./Classes/FixedArrayTypes/ ./Tests/

Where first argument is amount of sizes to be generated (from 1 up to given size including), second argument is path to put fixed array Swift files, and third argument is 
path to write Test file.

# Author
Alex Oakley [oakley@sublab.dev](mailto:%20oakley@sublab.dev)

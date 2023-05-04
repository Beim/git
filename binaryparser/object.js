// let zlib = require('zlib');

let CWD = "/home/ubuntu/git";
let OBJ_DIR = `${CWD}/.dircache/objects`;

/**
 * Select the files for which the parser should work.
 */
registerFileType((fileExt, filePath, fileData) => {
    // Check for the right file extension
    if (filePath.includes(OBJ_DIR)) {
        return true;
    }
    if (fileExt == 'bi') {
        return true;
    }
    return false;
});


/**
 * The parser to decode the file.
 */
registerParser(() => {
    addStandardHeader();
    // Put your code here
    // ...
    
    
    // addRow('t', inflateData(), 's')
    inflateData();
    // setDataBuffer([44, 44, 44, 44])

    // read tag
    let tagHex = '';
    let tag = '';
    readRowWithDetails('tag', () => {
        while (true) {
            read(1);
            let h = getHexValue();
            if (h == '20') { // space
                addRow('space')
                break;
            }
            tagHex += h;
            addRow('tag', h, hexToString(h));
        }
        tag = hexToString(tagHex);
        return {
            'value': `0x${tagHex}`,
            'description': tag,
        }
    });

        // read length
    let contentLength = 0;
    readRowWithDetails('length', () => {
        let lengthHex = '';
        while (true) {
            read(1);
            let h = getHexValue();
            if (h == '00') {
                addRow('\\0', getHex0xValue())
                break;
            }
            addRow('', getHex0xValue(), hexToString(getHexValue()))
            lengthHex += h;
        }
        contentLength = Number.parseInt(hexToString(lengthHex));
        return {
            'value': `0x${lengthHex}00`,
            'description': hexToString(lengthHex),
        }
    });

    // read content
    read(contentLength);
    addRow('content', getHex0xValue(), getStringValue())
});

function hexToString(hex) {
    var str = '';
    for (var i = 0; i < hex.length; i += 2) {
        var code = Number.parseInt(hex.substr(i, 2), 16);
        str += String.fromCharCode(code);
    }
    return str;
}

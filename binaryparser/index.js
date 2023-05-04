
let CWD = "/home/ubuntu/git";
let DIRCACHE_DIR = `${CWD}/.dircache`;
let indexFiles = [
    'index',
    'index.lock'
]

/**
 * Select the files for which the parser should work.
 */
registerFileType((fileExt, filePath, fileData) => {
    // Check for the right file extension
    if (fileExt == 'simplebi') {
        return true;
    }
    for (let v of indexFiles) {
        if (filePath == `${DIRCACHE_DIR}/${v}`) {
            return true;
        }
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

    // read cache_header
    read(4);
    addRow('signature', getHex0xValue(), hexToString(getHexValue()));
    // addRow('signature', getHex0xValue(), getStringValue());
    read(4);
    addRow('version', getHex0xValue(), '');
    read(4);
    let active_nr = getNumberValue();
    addRow('entries', getHex0xValue(), active_nr);
    read(20);
    addRow('sha1', getHex0xValue(), 'calculate from header and entries');

    // read cache_entry
    for (let i = 0; i < active_nr; i++) {
        read(4);
        addRow('ctime_sec', getHex0xValue(), getNumberValue())
        read(4);
        addRow('ctime_nsec', getHex0xValue(), getNumberValue())
        read(4);
        addRow('mtime_sec', getHex0xValue(), getNumberValue())
        read(4);
        addRow('mtime_nsec', getHex0xValue(), getNumberValue())
        read(4);
        addRow('st_dev', getHex0xValue(), getNumberValue())
        read(4);
        addRow('st_info', getHex0xValue(), getNumberValue())
        read(4);
        addRow('st_mode', getHex0xValue(), getNumberValue())
        read(4);
        addRow('st_uid', getHex0xValue(), getNumberValue())
        read(4);
        addRow('st_gid', getHex0xValue(), getNumberValue())
        read(4);
        addRow('st_size', getHex0xValue(), getNumberValue())
        read(20);
        addRow('sha1', getHex0xValue(), 'calc from sha1(deflate(blob object content))')
        read(2);
        let namelen = getNumberValue();
        addRow('namelen', getHex0xValue(), getNumberValue())
        read(namelen);
        addRow('name', getHex0xValue(), getStringValue())
    }

});


function hexToString(hex) {
    var str = '';
    for (var i = 0; i < hex.length; i += 2) {
        var code = Number.parseInt(hex.substr(i, 2), 16);
        str += String.fromCharCode(code);
    }
    return str;
}
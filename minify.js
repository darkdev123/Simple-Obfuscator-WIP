const fs = require('fs');
const minify = require('luamin');
const filePath = 'code.lua';
let luaCode = '';

fs.readFile(filePath, 'utf8', (err, data) => {
    if (err) {
    } else {
        luaCode = minify.minify(data)
        fs.writeFile(filePath, luaCode, (err) => {
            if (err) {
            } else {
        }
    });
}});
    
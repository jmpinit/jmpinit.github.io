/*
Simplified `npm init` behavior
*/

const path = require('path');
const { exec } = require('child_process');

function cmd(command) {
  return new Promise((fulfill, reject) => {
    exec(command, (err, stdout, stderr) => {
      if (err) {
        reject(err);
        return;
      }

      if (stderr.trim().length > 0) {
        reject(new Error(stderr));
        return;
      }

      fulfill(stdout);
    });
  });
}

function trim(text) {
  return new Promise((fulfill, reject) => fulfill(text.trim()));
}

// Our .npm-init.js module gets loaded by npm's promzard module
// which resolves our exports according to the procedure here
// https://github.com/npm/promzard/blob/8c37f2d873cf5686f4791cf89d0d0e662c8dceff/README.md
module.exports = {
  name: prompt('name', path.basename(process.cwd())),
  author: {
    name: cb => cmd('git config user.name')
      .then(trim)
      .then(name => cb(null, name))
      .catch(err => cb(err)),
    email: cb => cmd('git config user.email')
      .then(trim)
      .then(email => cb(null, email))
      .catch(err => cb(err)),
  },
  main: 'src/main.js',
  description: '',
  version: '1.0.0',
  license: 'MIT',
}

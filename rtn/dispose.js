const { existsSync, renameSync } = require('fs');
const path = require('path');

(async() => {
  const build_gradle = path.join(__dirname, '..', 'android', 'build.gradle');
  if (!existsSync(build_gradle)) {
    const old_path = path.join(__dirname, '..', 'android', 'build.gradle.rtn');
    const new_path = path.join(__dirname, '..', 'android', 'build.gradle');
    renameSync(old_path, new_path);
  }
})();
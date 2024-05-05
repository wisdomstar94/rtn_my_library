const { existsSync, renameSync } = require('fs');
const path = require('path');

(async() => {
  // build.gradle 처리
  const build_gradle = path.join(__dirname, '..', 'android', 'build.gradle');
  if (!existsSync(build_gradle)) {
    const old_path = path.join(__dirname, '..', 'android', 'build.gradle.rtn');
    const new_path = path.join(__dirname, '..', 'android', 'build.gradle');
    renameSync(old_path, new_path);
  }

  // 패키지 경로 처리
  const build_gradle_rtn_path = path.join(__dirname, '..', 'android', 'build.gradle.rtn');
  if (!existsSync(build_gradle_rtn_path)) {
    const old_package_path = path.join(__dirname, '..', 'android', 'app', 'src');
    const new_package_path = path.join(__dirname, '..', 'android', 'src');
    renameSync(old_package_path, new_package_path);
  }
})();
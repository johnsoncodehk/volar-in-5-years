// @ts-check
const axios = require('axios');
const sharp = require('sharp');
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const outputDir = './avatars';
const nameMap = {
    '翠 / green': 'sapphi-red',
};

if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir);
}

fetch('volar-services')
    .then(() => fetch('volar-volar.js'))
    .then(() => fetch('vue-atom'))
    .then(() => fetch('vue-coc'))
    .then(() => fetch('vue-lapce'))
    .then(() => fetch('vue-monaco'))
    .then(() => fetch('vue-sublime'))
    .then(() => fetch('vue-vine'))
    .then(() => fetch('vue-volar'))
// .then(() => fetch('vue-volar-dev')) // private repo

async function fetch(repoPath) {
    console.log(`Fetching avatars for ${repoPath}...`);
    const repoUrl = execSync('git config --get remote.origin.url', { cwd: path.join(__dirname, repoPath) }).toString().trim();
    const owner = repoUrl.split('/')[3];
    const repo = repoUrl.split('/')[4].replace('.git', '');
    const commits = execSync('git log --format="%an %H"', { cwd: path.join(__dirname, repoPath) }).toString().trim().split('\n');


    for (const commit of commits) {
        let [_, name, sha] = commit.match(/(.*) (.*)/);

        name = nameMap[name] ?? name;

        if (name.includes('/')) {
            console.log(`Skipping invalid name ${commit}`);
            continue;
        }

        if (!fs.existsSync(path.join(outputDir, `${name}_raw.png`))) {
            const { data: commitDetails } = await axios.get(`https://api.github.com/repos/${owner}/${repo}/commits/${sha}`);
            let uid;
            if (commitDetails.author) {
                uid = commitDetails.author.id;
            }
            else {
                try {
                    const pr = commitDetails.commit.message.match(/.*\(#(\d+)\)/);
                    const prNumber = pr[1];
                    const { data: prDetails } = await axios.get(`https://api.github.com/repos/${owner}/${repo}/pulls/${prNumber}`);
                    uid = prDetails.user.id;
                } catch {
                    console.log(`Failed to get author for ${commit}`);
                    continue;
                }
            }
            console.log(`Downloading avatar for ${name}...`);
            const avatar = await axios.get(`https://avatars.githubusercontent.com/u/${uid}?v=4`, { responseType: 'arraybuffer' });
            try {
                fs.writeFileSync(path.join(outputDir, `${name}_raw.png`), avatar.data);
            } catch {
                console.log(`Failed to save avatar for ${name}`);
                continue;
            }
        }

        if (!fs.existsSync(path.join(outputDir, `${name}.png`))) {
            await sharp(path.join(outputDir, `${name}_raw.png`))
                .resize(200, 200)
                .composite([{
                    input: Buffer.from(
                        `<svg><circle cx="100" cy="100" r="100"/></svg>`
                    ),
                    blend: 'dest-in'
                }])
                .png()
                .toFile(path.join(outputDir, `${name}.png`));
        }
    }
}

#!/usr/bin/env node
const fs = require('fs')
const path = require('path')
const child_process = require('child_process')

const godotBin = process.env.GODOT || 'godot'
const srcPath = path.resolve(__dirname, 'src')
const dstPath = path.resolve(__dirname, 'build')

let baseCommand = `"${godotBin}" --path "${srcPath}" --no-window`

function make(template, subDir, name) {
  console.log(`\x1b[33m\x1b[1mBuild ${template}\x1b[0m`)

  const buildPath = path.join(dstPath, subDir)

  if (fs.existsSync(buildPath)) {
    fs.rmdirSync(buildPath, {
      recursive: true
    })
  }

  fs.mkdirSync(buildPath)

  const proc = child_process.exec(
    `${baseCommand} --export "${template}" "${path.join(buildPath, name)}"`,
    (err, stdout, stderr) => {
      if (err) console.error(err)
      if (stderr) console.error(stderr)
      console.log('Done.')
    }
  )
}

make('HTML5', 'html5', 'index.html')
make('Windows Desktop', 'windows', 'Indigo.exe')
make('Mac OSX', 'mac', 'Indigo.zip')
make('Linux/X11', 'linux', 'Indigo')

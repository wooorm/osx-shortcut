# osx-shortcut ![`bin/sh`][bash]

> Add autocorrect text shortcuts, as in, when I type `$a`, its
> expanded to `$b`.

Tested on OS X 10.10 (Yosemite), might work earlier.

Uses undocumented features, meaning that this might break on new releases
of OS X (but your shortcuts will not).

## Install

[npm][]

```bash
npm install osx-shortcut --global
```

## Usage

```text
Usage: shortcut [options] <replace> <with>

Options:

  -h, --help     output usage information
  -v, --version  output version

You can also pass CSV on stdin(4).

Examples:

  $ shortcut "omw" "on my way"
  $ shortcut <<< "omw,on my way"

See also: man 1 shortcut
```

Go to `System Preferences` > `Keyboard` > `Text` to see your shortcuts.

![][screenshot]

## License

[MIT][] © [Titus Wormer][author]

[bash]: https://img.shields.io/badge/bin-sh-89e051.svg
[npm]: https://docs.npmjs.com/cli/install
[mit]: license
[author]: http://wooorm.com
[screenshot]: ./screenshot.png

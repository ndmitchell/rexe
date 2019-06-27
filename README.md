# rexe - Executable forwarder for Windows

On Windows, you can't overwrite a running binary. That means if you are writing a long running developer tool (e.g. [`ghcid`](https://github.com/ndmitchell/ghcid) in my case), it's hard to use that tool to develop itself. The `rexe` program solves that.

## Using `rexe`

If you want to use `rexe` to allow overwriting `ghcid`:

1. Get a copy of `rexe` from [here](https://github.com/ndmitchell/rexe/releases/download/v1/rexe.exe).
2. put that copy of `rexe.exe` on your `%PATH%`, before the real `ghcid.exe`.
3. Rename that copy fo `rexe.exe` to `ghcid.exe`.

Now running `ghcid` will run the `ghcid.exe` which is really `rexe.exe`. What `rexe` does is find the next similarly named binary, copy it to a temporary location, and run it. As a consequence, you can now overwrite the real `ghcid.exe`, since it's not actually running.

To compile the code run `ghc rexe.hs`, but unless you are changing `rexe`, it's easier to [use a precompiled binary](https://github.com/ndmitchell/rexe/releases/download/v1/rexe.exe).

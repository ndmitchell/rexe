
module Main(main) where

import Control.Monad.Extra
import System.Directory
import System.IO.Extra
import System.Environment
import System.FilePath
import System.Exit
import System.Process


main :: IO ()
main = do
    self <- canonicalizePath =<< getExecutablePath
    let exe = takeFileName self
    path <- splitSearchPath <$> getEnv "PATH"
    let f x = doesFileExist x &&^ fmap (self /=) (canonicalizePath x)
    exists <- findM f $ map (</> exe) path
    case exists of
        Nothing -> do
            fail $ "Can't find executable named " ++ exe ++ " on %PATH%"
            exitFailure
        Just prog -> do
            args <- getArgs
            withTempDir $ \dir -> do
                let dest = dir </> exe
                copyFile prog (dir </> exe)
                withCreateProcess (proc dest args) $ \_ _ _ pid -> exitWith =<< waitForProcess pid
